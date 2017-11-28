// Initialize Firebase
var config = 
{
    apiKey: "AIzaSyAbBnEsH-88WhhZqjG0xczXXriqvYRA_y4",
    authDomain: "silencetheecho-efa5e.firebaseapp.com",
    databaseURL: "https://silencetheecho-efa5e.firebaseio.com",
    projectId: "silencetheecho-efa5e",
    storageBucket: "silencetheecho-efa5e.appspot.com",
    messagingSenderId: "765642044089"
};
firebase.initializeApp(config);

// Get a reference to the database service
var database = firebase.database();

// Search database
function searchDatabase()
{
    var mediaSearch = document.getElementById("searchData").value; 
    return database.ref('/Media/' + mediaSearch).once('value').then(function(snapshot)
      {
          var mediaSource = snapshot.val(); 
          if (mediaSource != null)
          {
              localStorage.setItem("found", "true");
              localStorage.setItem("sourceName", mediaSearch);
              localStorage.setItem("accuracy", mediaSource["Accuracy"]);
              localStorage.setItem("bias", mediaSource["Bias"]); 
          }
          else
          {
              localStorage.setItem("found", "false");
              localStorage.setItem("sourceName", mediaSearch);
          }
          location.href = "https://silencetheecho.github.io/SilenceTheEcho/searchresults"; 
      }); 
}

// Update database
function updateDatabase(mediaSearch)
{
    return database.ref('/Requests/' + mediaSearch).set
    ({
        Accuracy: "Unknown",
        Bias: "Unknown"
    });
}


