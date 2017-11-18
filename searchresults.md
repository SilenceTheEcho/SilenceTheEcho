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
      <a href = "https://silencetheecho.github.io/SilenceTheEcho/">Home</a>
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
          document.getElementById("accuracy").textContent = "We did not find a media source by that name.";
      }
    </script>
  </body>
</html>

