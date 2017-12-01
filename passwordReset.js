var auth = firebase.auth();
//var emailAddress = "user@example.com";

document.querySelector('#submit').addEventListener('click', function(e) {
      e.preventDefault();
      e.stopPropagation();
      var emailAddress = document.querySelector('#email').value;
      var currentUser = firebase.auth().currentUser;
   
      // Send password reset
      firebase.auth().sendPasswordResetEmail(emailAddress).catch(function(error) {
       
            // Handle Errors here.
            var errorCode = error.code;
            var errorMessage = error.message;
            
            // If signed in user is null, create account
            if(errorCode == "auth/user-not-found"){
                 alert(errorMessage);
            } 
            else console.log(errorMessage);
      });
});
