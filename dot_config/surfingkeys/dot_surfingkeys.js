map("K", "R");
map("J", "E");
map("H", "S");
map("L", "D");
// settings.smoothScroll = false;
// settings.scrollStepSize = 140;

mapkey('<Ctrl-z>', 'fill in login form', function() {
 const origin = window.location.origin
    if(origin === "http://192.168.0.1"){           
   window.document.getElementById("txtPwd").value = "Qetuo0112" 
   window.document.getElementById("btnLogin").click() 
   return 
 }
});
