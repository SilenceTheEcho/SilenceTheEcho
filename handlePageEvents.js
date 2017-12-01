document.querySelector('#sign-in').addEventListener('click', function(e) {
      e.preventDefault();
      e.stopPropagation();
      var email = document.querySelector('#email').value;
      var password = document.querySelector('#password').value
      var currentUser = firebase.auth().currentUser;
      firebase.auth().onAuthStateChanged(function(user) {
          if (user)
          {
             if (user["email"] == email)
                 document.getElementById("signedIn").textContent = "You are already signed in as " + user["email"];
          }
      });
     
      // Sign in user
      var signedInUser = firebase.auth().signInWithEmailAndPassword(email, password).catch(function(error) {
       
            // Handle Errors here.
            var errorCode = error.code;
            var errorMessage = error.message;
            
            // If signed in user is null, create account
            if(errorCode == "auth/user-not-found"){
                  signedInUser = firebase.auth().createUserWithEmailAndPassword(email, password).then(function(){
                        var user = firebase.auth().currentUser;
                        document.getElementById("signedIn").textContent = "Your account has been registered and you are now signed in as " + user["email"];
                        user.sendEmailVerification().then(function() {
                        // Email sent.
                        }).catch(function(error) {
                              // An error happened.
                              console.log(error.message);
                        });
                  });
            } else console.log(errorMessage);
      });
});
        
document.querySelector('#sign-out').addEventListener('click', function(e) {
    e.preventDefault();
    e.stopPropagation();
    firebase.auth().signOut().then(function() {
        if (firebase.auth().currentUser == null)
             document.getElementById("signedIn").textContent = "You are now signed out.";
    });
});
