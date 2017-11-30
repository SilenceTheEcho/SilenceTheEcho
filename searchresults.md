<html>
  <head>
    <meta charset="utf-8">
    <title>Search Results</title>
    <script src = "https://www.gstatic.com/firebasejs/4.6.2/firebase.js"></script>
    <script src= "https://rawgit.com/SilenceTheEcho/SilenceTheEcho/master/samplesearch.js"></script>
  </head>
  <body>
    <section id = "contentSect">
      <h1 id = "sourceName"></h1> 
      <p id = "accuracy"></p> 
      <p id = "bias"></p>
      <p id = "addSource"></p>
      <p id = "explanation"></p>
    </section> 
    <script>
      if (localStorage.getItem("found") == "true")
      { 
          document.getElementById("sourceName").textContent = localStorage.getItem("sourceName"); 
          document.getElementById("accuracy").textContent = "Accuracy: " + localStorage.getItem("accuracy"); 
          document.getElementById("bias").textContent = "Bias: " + localStorage.getItem("bias");
          document.getElementById("explanation").textContent =
          "Accuracy scores range from 1 to 100.  Lower accuracy scores imply that the media source is providing media for entertainment or political purposes, and should not be a trusted source for news facts.  Accuracy scores above 75 are generally trustworthy.  Bias judgments range from Left Bias to Right Bias.  A judgment of Left Bias means that the media source uses language sympathetic to liberal causes, and covers stories critical towards conservatism.  A judgment of Right Bias means that the media source uses language critical of liberal causes, and covers stories sympathetic towards conservatism.  A completely unbiased source would be 'Least Bias'.";
      }
      else
      {
          document.getElementById("sourceName").textContent = localStorage.getItem("sourceName");
          document.getElementById("accuracy").textContent = "We did not find a media source by that name.";
          document.getElementById("addSource").textContent = "Would you like to request that this media source be added to our database?";
          var buttonResponse = document.createElement("p");
          buttonResponse.textContent = "We have received your request.  Our impartial panel of media adjudicators will review the media produced by " + document.getElementById("sourceName").textContent + " and enter the results of its findings into our database."; 
          var requestButton = document.createElement("button");
          requestButton.textContent = "Add Source";
          requestButton.addEventListener("click", function()
          {
              updateDatabase(document.getElementById("sourceName").textContent);
              document.getElementById("contentSect").appendChild(buttonResponse); 
          }); 
          document.getElementById("contentSect").appendChild(requestButton);
      }
    </script>
    <br>                                          
    <div>
        <a href = "https://silencetheecho.github.io/SilenceTheEcho/">Home</a>
    </div>
    <div>
        <a href = "https://silencetheecho.github.io/SilenceTheEcho/login">Log in or Register</a>
    </div>
    <div>
        <a href = "https://silencetheecho.github.io/SilenceTheEcho/faqs">FAQS</a>
    </div>
    <div>
        <a href = "https://silencetheecho.github.io/SilenceTheEcho/search">Try a different search</a>
    </div>
    <div>
        <a href = "https://silencetheecho.github.io/SilenceTheEcho/security">Security and Privacy Standards</a>
    </div>
  </body>
</html>

