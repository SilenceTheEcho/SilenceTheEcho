//
//  ViewController.swift
//  FirePhotos
//
//  Created by Dustin Pack on 8/24/17.
//  Copyright © 2017 Polemics Applications. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "Image").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        return button
    }()
    
    func handlePlusPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self //to set delegate to self add the protocols to the class above.  How do you know what protocols to add?  Command + click .delegate and see its definition of what protocols it requires.
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            plusPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let origionalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage { plusPhotoButton.setImage(origionalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width/2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        plusPhotoButton.layer.borderWidth = 3
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    func handleTextInputChange() {
        
        let isFormValid = emailTextField.text?.characters.count ?? 0 > 0 && usernameTextField.text?.characters.count ?? 0 > 0 && passwordTextField.text?.characters.count ?? 0 > 0
        
        if isFormValid {
            signupButton.isEnabled = true
            signupButton.backgroundColor = UIColor.rbg(red: 17, green: 154, blue: 237)
        } else {
            signupButton.isEnabled = false
            signupButton.backgroundColor = UIColor.rbg(red: 149, green: 204, blue: 244)
        }
        
        
        
    }
    
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor.rbg(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        button.isEnabled = false
        
        return button
    }()
    
    func handleSignUp(){
        guard let email = emailTextField.text, email.characters.count > 0 else {return}
        guard let username = usernameTextField.text, username.characters.count > 0 else {return}
        guard let password = passwordTextField.text, password.characters.count > 0 else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
          
            if let err = error {
                print("Failed to create user: ", err)
                return
            }
            
            print("Succesfully created user: ", user?.uid ?? "")
            
            //Needs to reference self because we are in a block.  self refers to the UIImaveView
            guard let image = self.plusPhotoButton.imageView?.image else { return}
            
            guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else {return}
            
            
            
            let filename = NSUUID().uuidString
            Storage.storage().reference().child("profile_images").child(filename).putData(uploadData, metadata: nil, completion: { (metadata, err) in
                
                if let err = err {
                    print("Failed to upload profile image: ", err)
                    return
                }
                
                guard let profileImageURL = metadata?.downloadURL()?.absoluteString else {return}
                
                print("Successfully uploaded profile image: ", profileImageURL)
                
                guard let uid = user?.uid else {return}
                
                let mediaArray = ["1600 Daily",
                                  "ABC News",
                                  "Addicting Info",
                                  "Advocate",
                                  "Aeon",
                                  "Airways",
                                  "Akkadian Times",
                                  "Al Arabiya",
                                  "Alternet",
                                  "BBC",
                                  "BNO News",
                                  "Backed By Fact",
                                  "Baltimore City Paper",
                                  "Bearing Arms",
                                  "Beating Libertarian",
                                  "Big Government News",
                                  "Big Think",
                                  "Bloomberg",
                                  "Blue Dot Daily",
                                  "C-SPAN",
                                  "CNBC",
                                  "Calgary Sun",
                                  "Canada Free Press",
                                  "Canadian Dimension",
                                  "Center for Integrity",
                                  "Circa News",
                                  "Clean Technica",
                                  "Clear Politics",
                                  "Consortium News",
                                  "DC Statesman",
                                  "Daily Business Review",
                                  "Daily Herald",
                                  "Daily Record",
                                  "Daily Telegraph",
                                  "Deadspin",
                                  "Defense One",
                                  "Desert Sun",
                                  "Die Hard Democrat",
                                  "Digg",
                                  "Doctors Without Borders",
                                  "EC Journal",
                                  "El Paris",
                                  "Elite Daily",
                                  "Fast Company",
                                  "Future in America",
                                  "Get Religion",
                                  "Gizmodo",
                                  "Global Integrity",
                                  "Global Post",
                                  "Globe Today",
                                  "Good Magazine",
                                  "Hayride",
                                  "Heat Street",
                                  "Hot Air",
                                  "Huffington Post",
                                  "IPolitics",
                                  "Ice News",
                                  "International Business Times",
                                  "Irish Times",
                                  "Just Facts",
                                  "Law Newz",
                                  "Left Action",
                                  "MSN",
                                  "Move On",
                                  "Nap-Sack",
                                  "National Journal",
                                  "National Monitor",
                                  "National Post",
                                  "National Review",
                                  "New York Post",
                                  "News Heist",
                                  "Newsbusters",
                                  "NextGov",
                                  "No Labels",
                                  "Oregonian",
                                  "PR Newswire",
                                  "Patriot News",
                                  "Red Flag News",
                                  "Republic Word",
                                  "Rewire",
                                  "SFGate",
                                  "Salon",
                                  "Slate",
                                  "Splinter",
                                  "TakePart",
                                  "The Australian",
                                  "The Federalist",
                                  "The Hill",
                                  "The Independent Review",
                                  "The Journal",
                                  "The Other 98%",
                                  "The Rebel",
                                  "This",
                                  "Toronto Star",
                                  "Truth Be Told",
                                  "Twitchy",
                                  "US Uncut",
                                  "USA Today",
                                  "Urban Institute",
                                  "Vanity Fair",
                                  "Voice of America",
                                  "Wall Street Journal",
                                  "Washington Post",
                                  "Weekly Standard",
                                  "WikiLeaks",
                                  "Wikipedia",
                                  "Wired Magazine",
                                  "World Magazine",
                                  "Youth Radio",]
                
                
                let randomIndex1 = Int(arc4random_uniform(UInt32(mediaArray.count)))
                let entry1 = mediaArray[randomIndex1]
                
                let randomIndex2 = Int(arc4random_uniform(UInt32(mediaArray.count)))
                let entry2 = mediaArray[randomIndex2]
                
                let randomIndex3 = Int(arc4random_uniform(UInt32(mediaArray.count)))
                let entry3 = mediaArray[randomIndex3]
                
                let randomIndex4 = Int(arc4random_uniform(UInt32(mediaArray.count)))
                let entry4 = mediaArray[randomIndex4]
                
                let userMediaArray = [entry1,entry2,entry3,entry4]
                
                let recomendationsarray = ["Business 2 Community",
                                          "C-SPAN",
                                          "China Daily",
                                          "Conflict News",
                                          "Consumerist",
                                          "Eagle Tribute",
                                          "Earth Institute",
                                          "Euronews",
                                          "FactsCan",
                                          "Financial Times",
                                          "Foreign Affairs",
                                          "Just Security",
                                          "Mental Floss",
                                          "Mention West",
                                          "Meta Bunkaddclose",
                                          "News Hawk",
                                          "Reuters",
                                          "Roll Call",
                                          "Science Debate",
                                          "Skimm",
                                          "The Pantagraph",
                                          "Third Way",
                                          "USA Spending Gov",
                                          "USAFacts",
                                          "WRAL",
                                          "Wikipedia"]
                
                let randomIndex5 = Int(arc4random_uniform(UInt32(recomendationsarray.count)))
                let entry5 = mediaArray[randomIndex5]
                
                let randomIndex6 = Int(arc4random_uniform(UInt32(recomendationsarray.count)))
                let entry6 = mediaArray[randomIndex6]
                
                let userRecomendationsArray = [entry5, entry6]
                
                
                let feedBiasArray = ["Left Bias", "Left-Center Bias", "Right-Center Bias", "Right Bias"]
                
                let randomIndex7 = Int(arc4random_uniform(UInt32(feedBiasArray.count)))
                let entry7 = feedBiasArray[randomIndex7]
                
                
                let feedAccuracy =  arc4random_uniform(79) + 10;
                
                let usernameValues = ["username": username, "Media Outlets" : userMediaArray, "Recommendations" : userRecomendationsArray, "Feed Bias" : entry7, "Feed Accuracy" : feedAccuracy] as [String : Any]
                let values = [uid: usernameValues]
                
            
    
                
                Database.database().reference().child("Users").updateChildValues(values, withCompletionBlock: { (err, ref) in
                    
                    if let err = err {
                        print("Failed to save user info into db:", err)
                        return
                    }
                    
                    print("Successfully saved user info to db")
                    //Sets variable to point at the root view defined in AppDelegate, then lets us execute commands from that view.
                    guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else {return}
                    mainTabBarController.setupViewControllers()
                    //self.dismiss(animated: true, completion: nil)
                })
            })
        

        }
    }
    
    let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "Sign In", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.rbg(red: 17, green: 154, blue: 237)]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleAlreadyHaveAccount), for: .touchUpInside)
        return button
    }()
    
    func handleAlreadyHaveAccount() {
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        view.backgroundColor = .white
        
        view.addSubview(plusPhotoButton)
        
        
        plusPhotoButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    
        setupInputFields()
    }

    fileprivate func setupInputFields() {
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signupButton])
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: plusPhotoButton.bottomAnchor, constant: 20),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            stackView.heightAnchor.constraint(equalToConstant: 200)
            ])
        
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 200)
        
        
    }
}


