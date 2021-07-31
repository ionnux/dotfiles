map("K", "R");
map("J", "E");
map("H", "S");
map("L", "D");
// settings.smoothScroll = false;
// settings.scrollStepSize = 140;

http://192.168.0.1/index.html#login
mapkey('<Ctrl-l>', 'fill in login form', function() {
 const origin = window.location.origin
 if(origin === "some-specific-domain"){           
  window.document.getElementById("username").value = username
   window.document.getElementById("password").value = password 
   window.document.getElementById("loginButton").click() 
   return 
 }
