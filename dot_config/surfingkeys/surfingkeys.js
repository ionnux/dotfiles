map("K", "R");
map("J", "E");
map("H", "S");
map("L", "D");
vmapkey("gs", "sg")
imap('jk', "<Esc>");
imap('jk', "<Bs>");

aceVimMap('jk', '<Esc>', 'insert');
// aceVimMap('<Alt-h>', '<Bs>', 'insert');
// aceVimMap('<Alt-w>', '<Ctrl-Bs>', 'insert');

// omnibar mappings
// cmap('<Ctrl-n>', '<Tab>');
// cmap('<Ctrl-p>', '<Shift-Tab>');

// settings.smoothScroll = false;
// settings.scrollStepSize = 140;

// mapkey('<Ctrl-z>', 'fill in login form', function() {
//  const origin = window.location.origin
//     if(origin === "http://192.168.0.1"){           
//    window.document.getElementById("txtPwd").value = "Qetuo0112" 
//    window.document.getElementById("btnLogin").click() 
//    return 
//  }
// });

settings.hintAlign = "left";
settings.useNeovim = false
