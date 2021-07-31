map("K", "R");
map("J", "E");
map("H", "S");
map("L", "D");
// settings.smoothScroll = false;
// settings.scrollStepSize = 140;

http://192.168.0.1/index.html#login
mapkey('<Ctrl-l>', 'fill in login form', function() {
 const origin = window.location.origin
    if(origin === "http://192.168.0.1/index.html#login"){           
   window.document.getElementById("txtPwd").value = Qetuo0112 
   window.document.getElementById("btnLogin").click() 
   return 
 }
});
