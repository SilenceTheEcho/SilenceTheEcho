<html>
  <head>
    <meta charset="utf-8">
    <title>Search Results</title>     
  </head>
  <body>
    <section>
      <h1 id = "sourceName"></h1> 
      <p id = "accuracy"></p> 
      <p id = "bias"></p>
      <p id = "mediaType"></p>
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
    </section> 
    <script>
      if (localStorage.getItem("found") == "true")
      { 
          document.getElementById("sourceName").textContent = localStorage.getItem("sourceName"); 
          document.getElementById("accuracy").textContent = "Accuracy: " + localStorage.getItem("accuracy"); 
          document.getElementById("bias").textContent = "Bias: " + localStorage.getItem("bias"); 
          document.getElementById("mediaType").textContent = "Media Type: " + localStorage.getItem("mediaType");
      }
      else
      {
          document.getElementById("sourceName").textContent = localStorage.getItem("sourceName");
          document.getElementById("accuracy").textContent = "So sorry, we did not find a media source by that name.";
      }
    </script>
  </body>
</html>

