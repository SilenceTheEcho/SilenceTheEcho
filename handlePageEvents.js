    document.querySelector('#sign-in').addEventListener('click', function(e) {
      e.preventDefault();
      e.stopPropagation();
      var email = document.querySelector('#email').value;
      var password = document.querySelector('#password').value
   //   var credential = firebase.auth().EmailAuthProvider.credential(email, password); commented this out (Patrick)
      var currentUser = firebase.auth().currentUser;
   //   firebase.auth().signIn(); //added this (DEM)
     // firebase.auth.emailAuthProvider.credential(emailInput.value, passwordInput.value);//added this (DEM)  
    //  firebase.auth.signInWithCredential(credential);//added this (DEM)
      // Step 2
      //  Get a credential with firebase.auth.emailAuthProvider.credential(emailInput.value, passwordInput.value)
      //  If there is no current user, log in with auth.signInWithCredential(credential)
      //  If there is a current user an it's anonymous, atttempt to link the new user with firebase.auth().currentUser.link(credential)
      //  The user link will fail if the user has already been created, so catch the error and sign in.
        // Added this - Patrick, commented out lines 6, 10, 11
        // Sign in user
        var signedInUser = firebase.auth().signInWithEmailAndPassword(email, password).catch(function(error) {
            // Handle Errors here.
            var errorCode = error.code;
            var errorMessage = error.message;
             // ...
            // If signed in user is null, create account
            if(errorCode == "auth/user-not-found"){
                signedInUser = firebase.auth().createUserWithEmailAndPassword(email, password);
            }
            else console.log(errorMessage);
        });
        
        // end add by patrick
    });
    document.querySelector('#sign-out').addEventListener('click', function(e) {
      e.preventDefault();
      e.stopPropagation();
      firebase.auth().signOut();
    });
