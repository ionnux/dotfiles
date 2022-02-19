const {
    aceVimMap,
    mapkey,
    imap,
    imapkey,
    getClickableElements,
    vmapkey,
    map,
    unmap,
    vunmap,
    cmap,
    addSearchAlias,
    removeSearchAlias,
    tabOpenLink,
    readText,
    Clipboard,
    Front,
    Hints,
    Visual,
    RUNTIME
} = api;

map("K", "R");
map("J", "E");
map("H", "S");
map("L", "D");
vmapkey("gs", "sg")
imap('jk', "<Esc>");
imap('<Ctrl-i>', "<Bs>");

aceVimMap('jk', '<Esc>', 'insert');
aceVimMap('<Ctrl-h>', '<Bs>', 'insert');
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
