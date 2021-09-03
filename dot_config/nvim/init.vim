"packer settings
lua require('plugins')

call plug#begin('~/.nvim/plugged')
" Plug 'ggandor/lightspeed.nvim' "motion plugin written in lua

" Plug 'tpope/vim-commentary'
" Plug 'kassio/neoterm'

" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

"Plug 'dense-analysis/ale'

" Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}

" Plug 'mhinz/vim-startify'

"Plug 'honza/vim-snippets'
" Plug 'SirVer/ultisnips'
"Plug 'norcalli/snippets.nvim'
" Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
" Plug 'numtostr/FTerm.nvim'

call plug#end()
set undofile
set undodir=~/.nvim/undo
set hidden

"nvim settings

"gruvbox settings
let g:gruvbox_contrast_dark = 'hard'
"set gruvbox contrast to hard. put this before the colorscheme setting
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

set colorcolumn=80
augroup colorcolumnToggle
    autocmd!
    autocmd FileType log set colorcolumn=""
augroup END

"increase nvim command timeout from 1000 to 2000
"set timeoutlen=2000

"hide insert display in insert mode
set noshowmode

set smartcase

" mouse support
set mouse=nv




"expand tabs into spaces

" disable curlorline highlighting

"when using << or >> commands, indent line by 4 spaces
set shiftwidth=4
set completeopt=menuone,noinsert,noselect

"set sign column to always on
set signcolumn=yes

"force nvim to use 256 color
set termguicolors


"do not highlight search
set nohlsearch


set nobackup
set cmdheight=1
set updatetime=600
set shortmess+=c

"nvim mappings
let mapleader = " "
"use space key as leader

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
nnoremap ;; :call SemiColonDelimiter()<cr>
nnoremap ,, :call CommaDelimiter()<cr>

function CommaDelimiter()
    let cursor_pos = getpos(".")
    if getline(".")[-1:] != ","
        execute "normal! A,\<esc>"
        call setpos(".", cursor_pos)
    else
        execute "normal! $x"
        call setpos(".", cursor_pos)
    endif
endfunction

function SemiColonDelimiter()
    let cursor_pos = getpos(".")
    if getline(".")[-1:] != ";"
        execute "normal! A;\<esc>"
        call setpos(".", cursor_pos)
    else
        execute "normal! $x"
        call setpos(".", cursor_pos)
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







"galaxyline settings
" lua require('galaxyline/my_theme')



"auto pairs settings
" let g:AutoPairsFlyMode = 1
" let g:AutoPairsShortcutBackInsert = '<M-b>'
" let g:AutoPairsShortcutFastWrap = '<c-f>'
" let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}

" filetype autopairs
" augroup autoPair
"     autocmd!
"     autocmd FileType dart let b:AutoPairs = AutoPairsDefine({'<':'>'})
"     autocmd FileType vim let b:AutoPairs = AutoPairsDefine({'lua <<EOF':'EOF'})
" augroup END
