//
//  MediaDBEntry.swift
//  FirePhotos
//
//  Created by Dustin Pack on 11/16/17.
//  Copyright © 2017 Polemics Applications. All rights reserved.
//

import UIKit
import Firebase


class ContentDBMaker: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    let mediaType: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Media Type"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    func handleTextInputChange() {
        
        let isFormValid = mediaType.text?.characters.count ?? 0 > 0 && TitleTextField.text?.characters.count ?? 0 > 0 && mediaSource.text?.characters.count ?? 0 > 0
        
        if isFormValid {
            signupButton.isEnabled = true
            signupButton.backgroundColor = UIColor.rbg(red: 17, green: 154, blue: 237)
        } else {
            signupButton.isEnabled = false
            signupButton.backgroundColor = UIColor.rbg(red: 149, green: 204, blue: 244)
        }
        
        
        
    }
    
    
    let TitleTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Title"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
    
    let mediaSource: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Media Source"
        //tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add STE Content Entry", for: .normal)
        button.backgroundColor = UIColor.rbg(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        button.isEnabled = false
        
        return button
    }()
    
    func handleSignUp(){
        guard let mediaType = mediaType.text, mediaType.characters.count > 0 else {return}
        guard let title = TitleTextField.text, title.characters.count > 0 else {return}
        guard let source = mediaSource.text, source.characters.count > 0 else {return}
        
        /*
         Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
         
         if let err = error {
         print("Failed to create Media: ", err)
         return
         }
         
         print("Succesfully created Media: ", user?.uid ?? "")
         */
        
        
        
        let filename = NSUUID().uuidString
        
        let uid = NSUUID().uuidString
        
        let rand =  arc4random_uniform(18) + 80;
        
        let values = ["Media Source": source, "Title" : title, "Type" : mediaType, "ID" : uid]
        //let valuesToSend = [uid: values]
        let valuesToSend = [title : values]
        
        Database.database().reference().child("Content").updateChildValues(valuesToSend, withCompletionBlock: { (err, ref) in
            
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
        
        setupInputFields()
    }
    
    fileprivate func setupInputFields() {
        
        let stackView = UIStackView(arrangedSubviews: [mediaType, TitleTextField, mediaSource, signupButton])
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            stackView.heightAnchor.constraint(equalToConstant: 200)
            ])
        
        stackView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 200, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 200)
        
        
    }
}


