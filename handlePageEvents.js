document.querySelector('#sign-in').addEventListener('click', function(e) {
      e.preventDefault();
      e.stopPropagation();
      var email = document.querySelector('#email').value;
      var password = document.querySelector('#password').value
      var currentUser = firebase.auth().currentUser;
      var signedIn = false;
      if (currentUser)
      {
          if (currentUser["email"] == email)
          {
              document.getElementById("signedIn").textContent = "You are already signed in as " + currentUser["email"] + ".";
              signedIn = true;
          }
      }
     
      // Sign in user
      var signedInUser = firebase.auth().signInWithEmailAndPassword(email, password).catch(function(error) {
       
            // Handle Errors here.
            var errorCode = error.code;
            var errorMessage = error.message;
            
            // If signed in user is null, create account
            if(errorCode == "auth/user-not-found"){
                  signedInUser = firebase.auth().createUserWithEmailAndPassword(email, password).then(function(){
                        var user = firebase.auth().currentUser;
                        user.sendEmailVerification().then(function() {
                        // Email sent.
                        }).catch(function(error) {
                              // An error happened.
                              console.log(error.message);
                        });
                  });
            } else console.log(errorMessage);
      });
      
      if (firebase.auth().currentUser && signedIn == false)
      {
         document.getElementById("signedIn").textContent = "Your account has been registered and you are now signed in as " + firebase.auth().currentUser["email"];
      }
});
        
document.querySelector('#sign-out').addEventListener('click', function(e) {
    e.preventDefault();
    e.stopPropagation();
    firebase.auth().signOut();
    if (firebase.auth().currentUser == null)
        document.getElementById("signedIn").textContent = "You are now signed out.";
});
