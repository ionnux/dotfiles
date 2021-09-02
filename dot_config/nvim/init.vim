"packer settings
lua require('plugins')

call plug#begin('~/.nvim/plugged')
" Plug 'ggandor/lightspeed.nvim' "motion plugin written in lua

Plug 'tpope/vim-surround'
" Plug 'tpope/vim-commentary'
" Plug 'puremourning/vimspector'
" Plug 'kassio/neoterm'

" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

"Plug 'dense-analysis/ale'

" Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}

" Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
" Plug 'ryanoasis/vim-devicons'

" Plug 'mhinz/vim-startify'

Plug 'ray-x/lsp_signature.nvim'
"Plug 'honza/vim-snippets'
" Plug 'SirVer/ultisnips'
"Plug 'norcalli/snippets.nvim'
" Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
" Plug 'numtostr/FTerm.nvim'

call plug#end()

"nvim settings

"gruvbox settings
"set gruvbox contrast to hard. put this before the colorscheme setting
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_sign_column = 'bg0'
" let g:gruvbox_italic = 1



" nord settings
let g:nord_contrast = v:true
let g:nord_borders = v:true
let g:nord_disable_background = v:true



"highlight settings for cusorline
function ColorSettings()

    if g:colors_name ==# "gruvbox"
        hi CocHighlightText guibg=#504945
        hi CocFloating guibg=#3c3836
        hi CocErrorFloat guifg=#ebdbb2
        hi CocErrorLine guibg=#282828
        hi CursorLine guibg=None
        hi CursorLineNr guifg=#fabd2f
        hi CursorLineNr guibg=None
        hi Pmenu guibg=#a89984
        hi Pmenu guifg=#282828
        hi PmenuSel guibg=#3c3836
        hi PmenuSel guifg=#fabd2f
        hi PmenuSbar guibg=#bdae93
        hi PmenuThumb guibg=#504945
        let g:airline_theme = 'base16_gruvbox_dark_hard'
    elseif g:colors_name ==# "dracula"
        hi CursorLine guibg=None
        hi CursorLineNr guifg=#f1fa8c
        hi CursorLineNr guibg=None
        "hi CocFloating guibg=#282828
        hi CocHighlightText guibg=#44475a
        " hi CocHighlightText guifg=#282a36
        hi CocErrorSign guifg=#ff79c6
    elseif g:colors_name ==# "tokyonight"
        hi CursorLineNr guibg=None
        hi CursorLineNr guifg=#7aa2f7
        " hi LineNr guifg=#7aa2f7
    elseif g:colors_name ==# "moonlight"
        highlight IncSearch guifg=white
        highlight IncSearch guibg=black
    endif
hi ColorColumn guibg=#292e42
endfunction

augroup Color
    autocmd!
    autocmd ColorScheme * :call ColorSettings()
    " autocmd ColorScheme * hi Normal guibg=None
augroup END



"fold settings
"function Fold()
    "if &filetype ==# "vim"
        "set foldmethod=expr
        "set foldexpr=getline(v:lnum)=~'^\\s*$'&&getline(v:lnum+1)=~'\\S'?'<1':1
    "else
        "set foldmethod=indent
    "endif
    "execute "normal! zR"
"endfunction
"autocmd BufWinEnter * call Fold()


"show line number
augroup numbertoggle
    autocmd!
    set number
    autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

augroup RelativeNumbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END


"set number of lines to keep above and below when scrolling
set scrolloff=8

set colorcolumn=80
augroup colorcolumnToggle
    autocmd!
    autocmd FileType log set colorcolumn=""
augroup END

"increase nvim command timeout from 1000 to 2000
"set timeoutlen=2000

"hide insert display in insert mode
set noshowmode

set ignorecase
set smartcase

" mouse support
set mouse=nv

" set maximum number of items to show in the popup menu
set pumheight=15

"set tab to have 4 spaces
set tabstop=4

"i'm setting this because of vi mundo
set undodir=~/.nvim/undo
set undofile

"expand tabs into spaces
set expandtab

" disable curlorline highlighting
set nocursorline

"when using << or >> commands, indent line by 4 spaces
set shiftwidth=4
set completeopt=menuone,noinsert,noselect

"set sign column to always on
set signcolumn=yes

"force nvim to use 256 color
set termguicolors

"open horizontal splits below the current window
set splitbelow

"do not highlight search
set nohlsearch

"open vertical splits to the right of the current window
set splitright

set hidden
set nobackup
set cmdheight=1
set updatetime=600
set shortmess+=c

"nvim mappings

"use space key as leader
nnoremap <SPACE> <Nop>
let mapleader=" "

" keep cursor in center of screen when transversing search
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ'z

" add undo break points whenever certain characters are pressed
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" populate jumplist whenever I move upward or downward 5 lines and above
nnoremap <expr> k (v:count > 4 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 4 ? "m'" . v:count : "") . 'j'

" mapping for moving line(s) in normal, insert and visual modes.
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv
" inoremap <c-k> <esc>:m .-2<cr>==
" inoremap <c-j> <esc>:m .+1<cr>==
nnoremap <leader>k <esc>:m .-2<cr>==
nnoremap <leader>j <esc>:m .+1<cr>==


" yank from cursor to eol
nnoremap Y y$

"map <leader>ev to edit my vimrc file
nnoremap <silent><leader>ev :edit ~/.local/share/chezmoi/dot_config/nvim/init.vim<cr>
function EditVimrc()
    if winwidth('.') > 110
        :vs $MYVIMRC
    else
        :e $MYVIMRC
    endif
endfunction

"map <leader>; to add delimiter to end of line.
nnoremap <leader>; :call Delimiter()<cr>
function Delimiter()
    let cursor_pos = getpos(".")
    if &filetype ==# "javascript"
        if getline(".")[-1:] != ";"
            execute "normal! A;\<esc>"
            call setpos(".", cursor_pos)
        else
            execute "normal! $x"
            call setpos(".", cursor_pos)
        endif
    elseif &filetype ==# "dart"
        if getline(".")[-1:] != ";"
            execute "normal! A;\<esc>"
            call setpos(".", cursor_pos)
        else
            execute "normal! $x"
            call setpos(".", cursor_pos)
        endif
    elseif &filetype ==# "json"
        if getline(".")[-1:] != ","
            execute "normal! A,\<esc>"
            call setpos(".", cursor_pos)
        else
            execute "normal! $x"
            call setpos(".", cursor_pos)
        endif
    endif
endfunction

"map <leader>sv to source my vimrc file
nnoremap <leader>sv :source $MYVIMRC<cr>

" map <leader>st to startify
nnoremap <leader>st :Startify<cr>

"press ctrl l to go to the end of line in insert mode
inoremap <c-l> <c-o>A

"use <leader>ww to write files
nnoremap <silent><leader>ww :write<cr>
nnoremap <silent><leader>wq :exit<cr>
nnoremap <silent><leader>bd :bdelete<cr>
nnoremap <leader>pi :PlugInstall<cr>


"use ctrl v to paste from android keyboard
" nnoremap <C-v> "+p
" inoremap <C-v> <C-r>+
"use the one below if the above does not work and you are using termux
"nnoremap <C-v> :r "!termux-clipboard-get <CR>
"inoremap <C-v> <ESC>:r !termux-clipboard-get <CR>A

"use jk to go to normal mode from insert mode
inoremap jk <Esc>

syntax on

"let me use escape key to go to normal mode from terminal mode
if has('nvim')
    "tnoremap <ESC> <C-\><C-n>
    "tnoremap <C-v><ESC> <ESC>
    tnoremap jk <C-\><C-n>
    tnoremap <C-h> <backspace>
endif

autocmd TermEnter * set timeoutlen=500
autocmd TermLeave * set timeoutlen=1000

"neoterm settings
"map <leader>ii to toggling neoterm
" nnoremap <silent> <leader>ii :<c-u>exec v:count.'Ttoggle'<cr>

"map <leader>id to deleting neoterm buffer
" nnoremap <silent><leader>id :Tclose!<cr>

"map <leader>if to send current file to REPL
" nnoremap <silent> <leader>if :TREPLSendFile<cr>

"map <leader>il to send current line to REPL
" nnoremap <silent> <leader>il :TREPLSendLine<cr>

"map <leader>is to send current selection to REPL
" vnoremap <silent> <leader>is :TREPLSendSelection<cr>

"Open the neoterm in a vertical split if current window width is bigger than 100, otherwise use a horizontal split.
" let g:neoterm_callbacks = {}
" function! g:neoterm_callbacks.before_new()
  " if winwidth('.') > 110
    " let g:neoterm_default_mod = 'botright vertical'
  " else
    " let g:neoterm_default_mod = 'botright'
  " end
" endfunction

"let g:neoterm_bracketed_paste = 1
"use bracketed paste for python
" autocmd filetype python let g:neoterm_bracketed_paste = 1

"don't use bracketed paste for python
" autocmd filetype javascript let g:neoterm_bracketed_paste = 0

"let g:neoterm_autojump = 1
" let g:neoterm_autoscroll = 1
" let g:neoterm_repl_python = 'ipython'


""ale settings
""linter setting
"let g:ale_linters = {
"\   'python': ['flake8', 'mypy'],
"\ }

""fixer setting
"let g:ale_fixers = {
"\   'python': ['black']
"\ }

""fix files when they are saved
"let g:ale_fix_on_save = 1

""ale would lint the buffer whenever a change is made to the buffer
"let g:ale_lint_on_text_changed = 'normal'

"" Bind 'leader f' to fixing problems with ALE
"nmap <leader>f <Plug>(ale_fix)

""enables highlighting problems on the number column
"let g:ale_sign_highlight_linenrs = 1

""format for echo message
"let g:ale_echo_msg_error_str = 'E'
"let g:ale_echo_msg_warning_str = 'W'
"let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

""ale and coc-vim integration
"let g:ale_disable_lsp = 1
""ale and airline integration
"let g:airline#extensions#ale#enabled = 1

""mypy settings
"let g:ale_python_mypy_options = "--strict --pretty"

"" Mappings in the style of unimpaired-next
"nmap <silent> [W <Plug>(ale_first)
"nmap <silent> [w <Plug>(ale_previous-wrap)
"nmap <silent> ]w <Plug>(ale_next-wrap)
"nmap <silent> ]W <Plug>(ale_last)




"startify settings
"startify bookmark setting
let g:startify_bookmarks = [ {'c': '~/.local/share/chezmoi/dot_config/nvim/init.vim'}]
let g:startify_update_oldfiles = 1
let g:startify_custom_indices = ['g', 'f', 'd', 's', 'a']
let g:startify_custom_header = [ " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
                                \" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
                                \" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
                                \" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
                                \" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",]




"Python
"Run python code
" autocmd filetype python nnoremap <silent><leader>rr :w \| sp \| set nonumber \| terminal python <C-r>\%<Cr>

"Debug python code
" autocmd filetype python nnoremap <silent><leader>dd :w \| sp \| set nonumber \| terminal ipdb3 <C-r>\%<Cr>


"javascript
"Run javascript code
" autocmd filetype javascript nnoremap <silent><leader>rr :w \| sp \| set nonumber \| terminal node <C-r>\%<Cr>



"indentline settings
" let g:indentLine_char = '┊'


"undotree settings
nnoremap <silent><leader>ut :UndotreeToggle<cr>
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_SplitWidth = 30
"let g:mundo_inline_undo = 1

autocmd BufReadPost *.kt setlocal filetype=kotlin



""lightspeed settings
"lua require('config/lightspeed')





" imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
" smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" numb nvim settings
"lua require('numb').setup()

" dart settings
augroup dartrun
    autocmd!
    autocmd filetype dart nnoremap <buffer><silent><leader>rr :w \| belowright 13split \| terminal dart --enable-asserts run <C-r>\%<Cr>i
augroup END

" flutter mappings
augroup flutterMappings
    autocmd!
    autocmd filetype dart nnoremap <buffer><silent><leader>fr :FlutterRun <cr>
    autocmd filetype dart nnoremap <buffer><silent><leader>fR :FlutterRestart <cr>
    autocmd filetype dart nnoremap <buffer><silent><leader>fe :FlutterEmulators <cr>
    autocmd filetype dart nnoremap <buffer><silent><leader>flc :FlutterLogClear <cr>
    autocmd filetype dart nnoremap <buffer><silent><leader>fo :FlutterOutlineToggle <cr>
    autocmd filetype dart nnoremap <buffer><silent><leader>fcp :FlutterCopyProfilerUrl <cr>
    autocmd filetype dart nnoremap <buffer><silent><leader>fvd :FlutterVisualDebug <cr>
    autocmd filetype dart nnoremap <buffer><silent><leader>fl :b __FLUTTER_DEV_LOG__ <cr>

    autocmd filetype log nnoremap <buffer><silent><leader>fr :FlutterRun <cr>
    autocmd filetype log nnoremap <buffer><silent><leader>fR :FlutterRestart <cr>
    autocmd filetype log nnoremap <buffer><silent><leader>fe :FlutterEmulators <cr>
    autocmd filetype log nnoremap <buffer><silent><leader>flc :FlutterLogClear <cr>
    autocmd filetype log nnoremap <buffer><silent><leader>fo :FlutterOutlineToggle <cr>
    autocmd filetype log nnoremap <buffer><silent><leader>fcp :FlutterCopyProfilerUrl <cr>
    autocmd filetype log nnoremap <buffer><silent><leader>fvd :FlutterVisualDebug <cr>

    autocmd filetype flutterToolsOutline nnoremap <buffer><silent><leader>fr :FlutterRun <cr>
    autocmd filetype flutterToolsOutline nnoremap <buffer><silent><leader>fR :FlutterRestart <cr>
    autocmd filetype flutterToolsOutline nnoremap <buffer><silent><leader>fe :FlutterEmulators <cr>
    autocmd filetype flutterToolsOutline nnoremap <buffer><silent><leader>flc :FlutterflutterToolsOutlineClear <cr>
    autocmd filetype flutterToolsOutline nnoremap <buffer><silent><leader>fo :FlutterOutlineToggle <cr>
    autocmd filetype flutterToolsOutline nnoremap <buffer><silent><leader>fcp :FlutterCopyProfilerUrl <cr>
    autocmd filetype flutterToolsOutline nnoremap <buffer><silent><leader>fvd :FlutterVisualDebug <cr>
augroup End

" Run chezmoi apply whenever I save a dotfile
augroup chezmoiApply
    autocmd!
    autocmd BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path %
augroup END




"nvimtree lua settings
let g:nvim_tree_side = 'left' "left by default
let g:nvim_tree_width = 25 "30 by default, can be width_in_columns or 'width_in_percent%'
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
let g:nvim_tree_gitignore = 1 "0 by default
let g:nvim_tree_auto_open = 0 "0 by default, opens the tree when typing `vim $DIR` or `vim`
let g:nvim_tree_auto_close = 1 "0 by default, closes the tree when it's the last window
let g:nvim_tree_auto_ignore_ft = [ 'startify', 'dashboard' ] "empty by default, don't auto open tree on specific filetypes.
let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
let g:nvim_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_hide_dotfiles = 0 "0 by default, this option hides files and folders starting with a dot `.`
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_highlight_opened_files = 3 "0 by default, will enable folder and file icon highlight for opened files/directories.
let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
let g:nvim_tree_tab_open = 1 "0 by default, will open the tree when entering a new tab and the tree was previously open
let g:nvim_tree_auto_resize = 0 "1 by default, will resize the tree to its saved width when opening a file
let g:nvim_tree_disable_netrw = 1 "1 by default, disables netrw
let g:nvim_tree_hijack_netrw = 1 "1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
let g:nvim_tree_add_trailing = 0 "0 by default, append a trailing slash to folder names
let g:nvim_tree_group_empty = 0 " 0 by default, compact folders that only contain a single folder into one node in the file tree
let g:nvim_tree_lsp_diagnostics = 1 "0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
let g:nvim_tree_disable_window_picker = 0 "0 by default, will disable the window picker.
let g:nvim_tree_hijack_cursor = 1 "1 by default, when moving cursor in the tree, will position the cursor at the start of the file on the current line
let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
" let g:nvim_tree_symlink_arrow = ' >> ' " defaults to ' ➛ '. used as a separator between symlinks' source and target.
let g:nvim_tree_update_cwd = 1 "0 by default, will update the tree cwd when changing nvim's directory (DirChanged event). Behaves strangely with autochdir set.
let g:nvim_tree_respect_buf_cwd = 1 "0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
let g:nvim_tree_window_picker_exclude = {
    \   'filetype': [
    \     'packer',
    \     'qf'
    \   ],
    \   'buftype': [
    \     'terminal'
    \   ]
    \ }
" Dictionary of buffer option names mapped to a list of option values that
" indicates to the window picker that the buffer's window should not be
" selectable.
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ 'folder_arrows': 0,
    \ }
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath.
"if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
"but this will not work when you set indent_markers (because of UI conflict)

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }

nnoremap <leader>nn :NvimTreeToggle<CR>
nnoremap <leader>nf :NvimTreeFocus<CR>
" NvimTreeOpen, NvimTreeClose and NvimTreeFocus are also available if you need them


" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=red
lua <<EOF
  local tree_cb = require'nvim-tree.config'.nvim_tree_callback
  vim.g.nvim_tree_bindings = {
    { key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit") },
    { key = {"<2-RightMouse>", "<C-]>"},    cb = tree_cb("cd") },
    { key = "<C-v>",                        cb = tree_cb("vsplit") },
    { key = "<C-s>",                        cb = tree_cb("split") },
    { key = "<C-t>",                        cb = tree_cb("tabnew") },
    { key = "<",                            cb = tree_cb("prev_sibling") },
    { key = ">",                            cb = tree_cb("next_sibling") },
    { key = "P",                            cb = tree_cb("parent_node") },
    { key = "<BS>",                         cb = tree_cb("close_node") },
    { key = "<S-CR>",                       cb = tree_cb("close_node") },
    { key = "<Tab>",                        cb = tree_cb("preview") },
    { key = "K",                            cb = tree_cb("first_sibling") },
    { key = "J",                            cb = tree_cb("last_sibling") },
    { key = "I",                            cb = tree_cb("toggle_ignored") },
    { key = "H",                            cb = tree_cb("toggle_dotfiles") },
    { key = "R",                            cb = tree_cb("refresh") },
    { key = "a",                            cb = tree_cb("create") },
    { key = "d",                            cb = tree_cb("remove") },
    { key = "r",                            cb = tree_cb("rename") },
    { key = "<C-r>",                        cb = tree_cb("full_rename") },
    { key = "x",                            cb = tree_cb("cut") },
    { key = "c",                            cb = tree_cb("copy") },
    { key = "p",                            cb = tree_cb("paste") },
    { key = "y",                            cb = tree_cb("copy_name") },
    { key = "Y",                            cb = tree_cb("copy_path") },
    { key = "gy",                           cb = tree_cb("copy_absolute_path") },
    { key = "[c",                           cb = tree_cb("prev_git_item") },
    { key = "]c",                           cb = tree_cb("next_git_item") },
    { key = "-",                            cb = tree_cb("dir_up") },
    { key = "s",                            cb = tree_cb("system_open") },
    { key = "q",                            cb = tree_cb("close") },
    { key = "g?",                           cb = tree_cb("toggle_help") },
  }
EOF


"lsp signature settings
lua <<EOF
require "lsp_signature".setup({
  bind = true, -- This is mandatory, otherwise border config won't get registered.
               -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                 -- set to 0 if you DO NOT want any API comments be shown
                 -- This setting only take effect in insert mode, it does not affect signature help in normal
                 -- mode, 10 by default

  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
  fix_pos = true,  -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = false, -- virtual hint enable
  hint_prefix = "🐼 ",  -- Panda for parameter
  hint_scheme = "String",
  use_lspsaga = false,  -- set to true if you want to use lspsaga popup
  hi_parameter = "incSearch", -- how your parameter will be highlight
  max_height = 20, -- max height of signature floating_window, if content is more than max_height, you can scroll down
                   -- to view the hiding contents
  max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
  handler_opts = {
    border = "single"   -- double, single, shadow, none
  },

  trigger_on_newline = false, -- sometime show signature on new line can be confusing, set it to false for #58
  extra_trigger_chars = {"(", ",", ":"}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  -- deprecate !!
  -- decorator = {"`", "`"}  -- this is no longer needed as nvim give me a handler and it allow me to highlight active parameter in floating_window
  zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
  debug = false, -- set to true to enable debug logging
  log_path = "debug_log_file_path", -- debug log path

  padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  toggle_key = nil -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
})
EOF

"galaxyline settings
" lua require('galaxyline/my_theme')



"auto pairs settings
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutBackInsert = '<M-b>'
let g:AutoPairsShortcutFastWrap = '<c-f>'
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}

" filetype autopairs
" augroup autoPair
"     autocmd!
"     autocmd FileType dart let b:AutoPairs = AutoPairsDefine({'<':'>'})
"     autocmd FileType vim let b:AutoPairs = AutoPairsDefine({'lua <<EOF':'EOF'})
" augroup END
