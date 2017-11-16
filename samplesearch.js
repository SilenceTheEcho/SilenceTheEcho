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

// Page url
var url = "file:///C:/Users/Ryan%20Brooks/Desktop/OSU_CS/CS_361_Software_Engineering_1/Group%20Project/hw6"; 

// Search database
function searchDatabase()
{
    var mediaSearch = document.getElementById("searchData").value; 
    return database.ref(mediaSearch).once('value').then(function(snapshot)
      {
          var mediaSource = snapshot.val(); 
          if (mediaSource != null)
          {
              localStorage.setItem("found", "true");
              localStorage.setItem("sourceName", mediaSearch);
              localStorage.setItem("accuracy", mediaSource["Accuracy"]);
              localStorage.setItem("bias", mediaSource["Bias"]);
              localStorage.setItem("mediaType", mediaSource["Media Type"]); 
          }
          else
          {
              localStorage.setItem("found", "false");
              localStorage.setItem("sourceName", mediaSearch);
          }
          location.href = url + "/samplesearch.html"; 
      }); 
}




