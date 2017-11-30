document.querySelector('#sign-in').addEventListener('click', function(e) {
      e.preventDefault();
      e.stopPropagation();
      var email = document.querySelector('#email').value;
      var password = document.querySelector('#password').value
      var currentUser = firebase.auth().currentUser;
   
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
});
        
document.querySelector('#sign-out').addEventListener('click', function(e) {
    e.preventDefault();
    e.stopPropagation();
    firebase.auth().signOut();
});

function userSignedIn()
{
      // If user sign in successful, redirect to search.
      //window.location.href = 'https://silencetheecho.github.io/SilenceTheEcho/search';
      var signedIn = document.getElementById("signedIn");
      if (firebase.auth().currentUser)
      {
         signedIn.textContent = "You are signed in as " + firebase.auth().currentUser["email"];
      }
      else if (signedIn)
      {
         signedIn.textContent = "";
      }
}
