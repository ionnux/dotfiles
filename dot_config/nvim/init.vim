call plug#begin('~/.nvim/plugged')
" Plug 'easymotion/vim-easymotion'
Plug 'ggandor/lightspeed.nvim' "motion plugin written in lua
Plug 'dstein64/nvim-scrollview' "scrollbar plugin
Plug 'sheerun/vim-polyglot'
"Plug 'frazrepo/vim-rainbow'
"syntax highlighter for javascript
"Plug 'yuezk/vim-js'
Plug 'simnalamburt/vim-mundo'
Plug 'mbbill/undotree'
"Plug 'justinmk/vim-sneak'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
" Plug 'b3nj5m1n/kommentary' "commentary plugin written in lua
" Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'mhartington/formatter.nvim'
Plug 'nacro90/numb.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'akinsho/flutter-tools.nvim'
Plug 'dart-lang/dart-vim-plugin'

Plug 'kassio/neoterm'
Plug 'haringsrob/nvim_context_vt' "show virtual text of current context

" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

"Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs'

Plug 'folke/trouble.nvim'
Plug 'folke/twilight.nvim'
Plug 'folke/zen-mode.nvim'
Plug 'folke/which-key.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'

" Plug 'joshdick/onedark.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'arzg/vim-substrata'
Plug 'shaunsingh/nord.nvim'
Plug 'kyazdani42/blue-moon'
Plug 'shaunsingh/moonlight.nvim'
Plug 'dracula/vim',{'as':'dracula'}
Plug 'folke/tokyonight.nvim'
Plug 'norcalli/nvim-colorizer.lua' " color highlighter
Plug 'hoob3rt/lualine.nvim'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'kyazdani42/nvim-web-devicons'
" Plug 'ryanoasis/vim-devicons'

Plug 'mhinz/vim-startify'
" Plug 'roman/golden-ratio'

Plug 'neovim/nvim-lspconfig'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'L3MON4D3/LuaSnip'
Plug 'norcalli/snippets.nvim'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'numtostr/FTerm.nvim'
Plug 'onsails/lspkind-nvim' "add vscode-like pictograms to builtin lsp

Plug 'p00f/nvim-ts-rainbow'

" dart and flutter related
Plug 'Neevash/awesome-flutter-snippets' "flutter snippets
Plug 'Alexisvt/flutter-snippets' "flutter snippets
Plug 'akinsho/dependency-assist.nvim' "dependency assist for dart

" Games
Plug 'alec-gibson/nvim-tetris'
call plug#end()

"nvim settings

"gruvbox settings
"set gruvbox contrast to hard. put this before the colorscheme setting
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_sign_column = 'bg0'
" let g:gruvbox_italic = 1

" tokyonight settings
let g:tokyonight_style = "night"
let g:tokyonight_day_brightness = 0.1
let g:tokyonight_transparent = 0
let g:tokyonight_lualine_bold = 1
" let g:tokyonight_italic_functions = 1
" let g:tokyonight_italic_variables = 1
" let g:tokyonight_hide_inactive_statusline = 1

" nord settings
let g:nord_contrast = v:true
let g:nord_borders = v:true
let g:nord_disable_background = v:true


" colorscheme gruvbox
" colorscheme dracula
colorscheme tokyonight
" colorscheme substrata
" colorscheme moonlight
" colorscheme blue-moon
" colorscheme nord

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
set number
augroup numbertoggle
    autocmd!
    autocmd TermEnter * set nonumber
    autocmd TermLeave * set number
augroup END

"show relative number
set relativenumber
"settings for when to show relativenumber
augroup relativenumbertoggle
  autocmd!
  autocmd BufEnter,InsertLeave,WinEnter,TermLeave * set relativenumber
  autocmd BufLeave,InsertEnter,WinLeave,TermEnter  * set norelativenumber
augroup END


"set number of lines to keep above and below when scrolling
set scrolloff=8

set colorcolumn=80

"increase nvim command timeout from 1000 to 2000
"set timeoutlen=2000

"hide insert display in insert mode
set noshowmode

" mouse support
set mouse=nv

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
nnoremap <leader>sp :set paste<cr>
nnoremap <leader>snp :set nopaste<cr>
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



"easymotion settings
" let g:EasyMotion_verbose = 0
" let g:EasyMotion_use_upper = 1
" let g:EasyMotion_keys = 'ASDGHKLQWERTYUIOPZXCVBNMFJ;'
" let g:EasyMotion_smartcase = 1

"two character search
"nmap s <Plug>(easymotion-s2)
"nmap t <Plug>(easymotion-t2)

"n character search
"map  / <Plug>(easymotion-sn)
"omap / <Plug>(easymotion-tn)
"map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)



"ultisnips settings
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'

"vim-rainbow settings
"let g:rainbow_active = 1


"golden ratio settings
"let g:loaded_golden_ratio = 0
"let g:golden_ratio_exclude_nonmodifiable = 1
"nmap yog <Plug>(golden_ratio_toggle)



"nerdtree settings
"nnoremap <leader>nn :NERDTree<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
nnoremap <leader>nt :NERDTreeFocus<CR>
nnoremap <leader>nn :NERDTreeToggle<CR>



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



"autopairs settings
let g:AutoPairsFlyMode = 1



"airline settings
"this setting automatically populate the g:airline_symbols dictionary with the powerline symbols.
let g:airline_powerline_fonts = 1

"enable/disable bufferline integration >
"let g:airline#extensions#bufferline#enabled = 1

"determine whether bufferline will overwrite customization variables >
"let g:airline#extensions#bufferline#overwrite_variables = 1

"enable tabline
let g:airline#extensions#tabline#enabled = 1

"show buffer number in tabline
let g:airline#extensions#tabline#buffer_nr_show = 1

"tabline formatter
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" let g:airline_focuslost_inactive=0
" let g:airline_inactive_alt_sep=0
" let g:airline_inactive_collapse=0
"airlinetheme setting
" function AirlineTheme()
"     if g:colors_name ==# "gruvbox"
"         :AirlineTheme base16_gruvbox_dark_hard
"         " :AirlineTheme gruvbox
"     endif
" endfunction

" augroup AirlineTheme
"     autocmd!
"     autocmd SourcePost * :call AirlineTheme()
"     " autocmd SourcePost * :call AirlineTheme()
" augroup END




"startify settings
"startify bookmark setting
let g:startify_bookmarks = [ {'c': '~/.local/share/chezmoi/dot_config/nvim/init.vim'}]
"startify indices setting
let g:startify_custom_indices = ['g', 'f', 'd', 's', 'a']
"automatically set airline theme to gruvbox whenever startify starts

""deoplete settings
"let g:deoplete#enable_at_startup = 1

"" Trigger configuration. Do not use <tab> if you use
"let g:UltiSnipsExpandTrigger='<tab>'

"" shortcut to go to next position
"let g:UltiSnipsJumpForwardTrigger='<Tab>'

"" shortcut to go to previous position
"let g:UltiSnipsJumpBackwardTrigger='<c-k>'





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



"vim-maximizer settings
nnoremap <silent><leader>m :MaximizerToggle!<CR>
vnoremap <silent><leader>m :MaximizerToggle!<CR>gv



"fzf settings
" nnoremap <silent><leader>ff :Files<cr>
" nnoremap <silent><leader>fif :Rg<cr>
" nnoremap <silent><leader>fb :Buffers<cr>
" nnoremap <silent><leader>fbl :BLines<cr>
" nnoremap <silent><leader>fh :History<cr>
" nnoremap <silent><leader>fc :Commands<cr>
" nnoremap <silent><leader>fch :History:<cr>
" nnoremap <silent><leader>fsh :History/<cr>
" nnoremap <silent><leader>fcs :Colors<cr>


"telescope settings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


"vim mundo settings
nnoremap <silent><leader>vm :MundoToggle<cr>

"undotree settings
nnoremap <silent><leader>ut :UndotreeToggle<cr>
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
"let g:mundo_inline_undo = 1

autocmd BufReadPost *.kt setlocal filetype=kotlin

"nvim-compe settings
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.treesitter = v:false
let g:compe.source.emoji = v:true

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
" Tab and S-Tab completion
" inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" C-j and C-k completion
inoremap <silent><expr> <C-j> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-h>"



"vimls setup
lua <<EOF
require'lspconfig'.vimls.setup{}
EOF

"lspsaga setup
lua <<EOF
  local saga = require 'lspsaga'
  saga.init_lsp_saga {
    use_saga_diagnostic_sign = true,
    error_sign = '',
    warn_sign = '',
    --hint_sign = '',
    hint_sign = '',
    infor_sign = '',
    dianostic_header_icon = '   ',
    code_action_icon = ' ',
    code_action_prompt = {
      enable = true,
      sign = false,
      sign_priority = 20,
      virtual_text = true,
    },
    finder_definition_icon = '  ',
    finder_reference_icon = '  ',
    max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
    finder_action_keys = {
      open = 'o', vsplit = 'v',split = 's',quit = 'q',scroll_down = '<C-j>', scroll_up = '<C-k>' -- quit can be a table
    },
    code_action_keys = {
      quit = 'q',exec = '<CR>'
    },
    rename_action_keys = {
      quit = '<C-c>',exec = '<CR>'  -- quit can be a table
    },
    definition_preview_icon = '  ',
    --"single" "double" "round" "plus" "bold"
    border_style = "single",
    rename_prompt_prefix = '➤',
  }
EOF
"definition and references
" nnoremap <silent> gh :Lspsaga lsp_finder<CR>
nnoremap <silent> gd :Lspsaga lsp_finder<CR>
"Code Action
" nnoremap <silent><leader>ca :Lspsaga code_action<CR>
" vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
nnoremap <silent><leader>qq :Lspsaga code_action<CR>
vnoremap <silent><leader>qq :<C-U>Lspsaga range_code_action<CR>
" show hover doc
nnoremap <silent>K :Lspsaga hover_doc<CR>
" scroll down hover doc or scroll in definition preview
nnoremap <silent> <C-j> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
" scroll up hover doc
nnoremap <silent> <C-k> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
" show signature help
nnoremap <silent> gs :Lspsaga signature_help<CR>
inoremap gsh <c-o>:Lspsaga signature_help<cr>
" rename
" nnoremap <silent>gr :Lspsaga rename<CR>
nnoremap <silent><leader>rn :Lspsaga rename<CR>
" preview definition
nnoremap <silent> gh :Lspsaga preview_definition<CR>
"diagnostics
" show
nnoremap <silent> <leader>ld :Lspsaga show_line_diagnostics<CR>
" only show diagnostic if cursor is over the area
nnoremap <silent> <leader>cd :Lspsaga show_cursor_diagnostics<CR>
" jump diagnostic
nnoremap <silent> ]g :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> [g :Lspsaga diagnostic_jump_prev<CR>
" float terminal also you can pass the cli command in open_float_terminal function
nnoremap <silent> <A-d> :Lspsaga open_floaterm<CR>
tnoremap <silent> <A-d> <C-\><C-n>:Lspsaga close_floaterm<CR>
" automatically show diagnostics in hover window
autocmd CursorHold * lua require'lspsaga.diagnostic'.show_line_diagnostics()


"flutter-tools settings
lua <<EOF
  require("flutter-tools").setup{
  widget_guides = {
    enabled = true,
    },
  dev_tools = {
    autostart = true,
    auto_open_browser = false,
    },
  } -- use defaults
EOF

" dart vim settings
let g:dartfmt_options = ['--fix']
augroup FormatDart
    autocmd!
    autocmd BufWritePost *.dart DartFmt
augroup END

" FTerm settings
" lua <<EOF
" require('FTerm').setup()

" require'FTerm'.setup({
"     dimensions  = {
"         height = 0.8,
"         width = 0.8,
"         x = 0.5,
"         y = 0.5
"     },
"     border = 'single' -- or 'double'
" })

" -- Keybinding
" local map = vim.api.nvim_set_keymap
" local opts = { noremap = true, silent = true }

" map('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>', opts)
" map('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)
" EOF

" vim-snippets settings
" flutter integration
autocmd BufRead,BufNewFile,BufEnter *.dart UltiSnipsAddFiletypes dart-flutter

" " nvim-lspconfig settings
" lua <<EOF
" local M = {}
" M.icons = {
"   Class = " ",
"   Color = " ",
"   Constant = " ",
"   Constructor = " ",
"   Enum = "了 ",
"   EnumMember = " ",
"   Field = " ",
"   File = " ",
"   Folder = " ",
"   Function = " ",
"   Interface = "ﰮ ",
"   Keyword = " ",
"   Method = "ƒ ",
"   Module = " ",
"   Property = " ",
"   Snippet = "﬌ ",
"   Struct = " ",
"   Text = " ",
"   Unit = " ",
"   Value = " ",
"   Variable = " ",
" }

" function M.setup()
"   local kinds = vim.lsp.protocol.CompletionItemKind
"   for i, kind in ipairs(kinds) do
"     kinds[i] = M.icons[kind] or kind
"   end
" end

" return M
" EOF

" disable diagnostic virtual text
lua <<EOF
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    severity_sort = false,
    }
)
EOF

" lualine settings
lua <<EOF
require('lualine').setup {
options = {
    theme = "tokyonight",
    --theme = "moonlight",
    section_separators = { "", "" },
    component_separators = { "", "" },
    -- section_separators = { "", "" },
    -- component_separators = { "", "" },
    icons_enabled = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { 
                    { 
                        'diagnostics', 
                        sources = { "nvim_lsp" },
                    }, 
                    {
                        'filename',
                        file_status = true,
                        path = 1,
                    }
                },
    lualine_x = { 'filetype', lsp_progress },
    lualine_y = { "progress" },
    lualine_z = { 'location' },
    --lualine_z = { clock },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {'nerdtree', 'quickfix'}
}
EOF

" nvim bufferline settings
lua <<EOF
require("bufferline").setup{
  options = {
    --numbers = "buffer_id", 
    number_style = "",
    diagnostics = "nvim_lsp",
    show_buffer_close_icons = falsetrue,
    show_close_icon = false,
    show_tab_indicators = true,
    --seperator_style = "slant"
    }
}
EOF

" nvim colorizer settings
lua require'colorizer'.setup()

" nvim treesitter settings
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },
}
EOF

" " trouble nvim settings
" lua <<EOF
"   require("trouble").setup {
"     }

"   -- keymappings
"   vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true})
"   vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", {silent = true, noremap = true})
"   vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>TroubleToggle lsp_document_diagnostics<cr>", {silent = true, noremap = true})
"   vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", {silent = true, noremap = true})
"   vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", {silent = true, noremap = true})
"   vim.api.nvim_set_keymap("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", {silent = true, noremap = true})
"   vim.api.nvim_set_keymap("n", "gD", "<cmd>TroubleToggle lsp_definitions<cr>", {silent = true, noremap = true})

" EOF

" which-key settings
lua <<EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

" zen mode settings
lua << EOF
  require("zen-mode").setup {
    window = {
      backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
      -- height and width can be:
      -- * an absolute number of cells when > 1
      -- * a percentage of the width / height of the editor when <= 1
      -- width = 120, -- width of the Zen window
      width = 1, -- width of the Zen window
      height = 1, -- height of the Zen window
      -- by default, no options are changed for the Zen window
      -- uncomment any of the options below, or add other vim.wo options you want to apply
      options = {
        -- signcolumn = "no", -- disable signcolumn
        -- number = false, -- disable number column
        -- relativenumber = false, -- disable relative numbers
        -- cursorline = false, -- disable cursorline
        -- cursorcolumn = false, -- disable cursor column
        -- foldcolumn = "0", -- disable fold column
        -- list = false, -- disable whitespace characters
      },
    },
    plugins = {
      -- disable some global vim options (vim.o...)
      -- comment the lines to not apply the options
      options = {
        enabled = true,
        ruler = false, -- disables the ruler text in the cmd line area
        showcmd = false, -- disables the command in the last line of the screen
      },
      twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
      gitsigns = { enabled = false }, -- disables git signs
      tmux = { enabled = false }, -- disables the tmux statusline
      -- this will change the font size on kitty when in zen mode
      -- to make this work, you need to set the following kitty options:
      -- - allow_remote_control socket-only
      -- - listen_on unix:/tmp/kitty
    },
    -- callback where you can add custom code when the Zen window opens
    on_open = function(win)
    end,
    -- callback where you can add custom code when the Zen window closes
    on_close = function()
    end,

  }
EOF
nnoremap <leader>zm :ZenMode<cr>


" twilight settings
lua << EOF
  require("twilight").setup {
    dimming = {
      alpha = 0.5, -- amount of dimming
      -- we try to get the foreground from the highlight groups or fallback color
      color = { "Normal", "#ffffff" },
    },
    context = 10, -- amount of lines we will try to show around the current line
    -- treesitter is used to automatically expand the visible text,
    -- but you can further control the types of nodes that should always be fully expanded
    expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
      "function",
      "method",
      "table",
      "if_statement",
    },
   --exclude = {"vim"}, -- exclude these filetypes
  }
EOF
nnoremap <leader>tt :Twilight<cr>

" dependency assist settings
lua <<EOF
  require'dependency_assist'.setup{}
EOF


"lightspeed settings
lua <<EOF
  require'lightspeed'.setup {
    jump_to_first_match = true,
    jump_on_partial_input_safety_timeout = 400,
    -- This can get _really_ slow if the window has a lot of content,
    -- turn it on only if your machine can always cope with it.
    highlight_unique_chars = false,
    grey_out_search_area = true,
    match_only_the_start_of_same_char_seqs = true,
    limit_ft_matches = 5,
    full_inclusive_prefix_key = '<c-x>',
    -- By default, the values of these will be decided at runtime,
    -- based on `jump_to_first_match`.
    labels = nil,
    cycle_group_fwd_key = nil,
    cycle_group_bwd_key = nil,
  }
    function repeat_ft(reverse)
      local ls = require'lightspeed'
      ls.ft['instant-repeat?'] = true
      ls.ft:to(reverse, ls.ft['prev-t-like?'])
    end
    vim.api.nvim_set_keymap('n', ';', '<cmd>lua repeat_ft(false)<cr>',
                            {noremap = true, silent = true})
    vim.api.nvim_set_keymap('x', ';', '<cmd>lua repeat_ft(false)<cr>',
                            {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', ',', '<cmd>lua repeat_ft(true)<cr>',
                            {noremap = true, silent = true})
    vim.api.nvim_set_keymap('x', ',', '<cmd>lua repeat_ft(true)<cr>',
                            {noremap = true, silent = true})
EOF


" nvim ts rainbow settings
lua <<EOF
  require'nvim-treesitter.configs'.setup {
    rainbow = {
      enable = true,
      extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
      max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
      colors = {  
        "#cc241d",
        "#a89984",
        "#b16286",
        "#d79921",
        "#689d6a",
        "#d65d0e",
        "#458588",
       }, -- table of hex strings
      termcolors = {
        'Red',
	    'Green',
	    'Yellow',
	    'Blue',
	    'Magenta',
	    'Cyan',
	    'White',
      }, -- table of colour name strings
    },
  }
EOF


" moonlight nvim settings
lua <<EOF
vim.g.moonlight_italic_comments = true
vim.g.moonlight_italic_keywords = true
vim.g.moonlight_italic_functions = true
vim.g.moonlight_italic_variables = true
vim.g.moonlight_contrast = true
vim.g.moonlight_borders = true
-- load the colorscheme
--require('moonlight').set()
EOF


" lspkind settings
lua <<EOF
  require('lspkind').init({
      -- enables text annotations
      --
      -- default: true
      with_text = true,
  
      -- default symbol map
      -- can be either 'default' or
      -- 'codicons' for codicon preset (requires vscode-codicons font installed)
      --
      -- default: 'default'
      preset = 'codicons',
  
      -- override preset symbols
      --
      -- default: {}
      symbol_map = {
        Text = '',
        Method = 'ƒ',
        Function = '',
        Constructor = '',
        Variable = '',
        Class = '',
        Interface = 'ﰮ',
        Module = '',
        Property = '',
        Unit = '',
        Value = '',
        Enum = '了',
        Keyword = '',
        Snippet = '﬌',
        Color = '',
        File = '',
        Folder = '',
        EnumMember = '',
        Constant = '',
        Struct = ''
      },
  })
EOF

" " kommentary settings
" lua <<EOF
"   require('kommentary.config').configure_language("default", {
"       prefer_multi_line_comments = true,
"   })
"   vim.api.nvim_set_keymap("n", "<leader>cic", "<Plug>kommentary_line_increase", {})
"   vim.api.nvim_set_keymap("n", "<leader>ci", "<Plug>kommentary_motion_increase", {})
"   vim.api.nvim_set_keymap("x", "<leader>ci", "<Plug>kommentary_visual_increase", {})
"   vim.api.nvim_set_keymap("n", "<leader>cdc", "<Plug>kommentary_line_decrease", {})
"   vim.api.nvim_set_keymap("n", "<leader>cd", "<Plug>kommentary_motion_decrease", {})
"   vim.api.nvim_set_keymap("x", "<leader>cd", "<Plug>kommentary_visual_decrease", {})
" EOF

" indent blankline settings
let g:indent_balnkline_use_treesitter = v:true
let g:indent_blankline_filetype_exclude = ['help', 'startify', 'man', 'vim']
let g:indent_blankline_char = '¦'


" formatter nvim settings
lua <<EOF
  require('formatter').setup({
    logging = false,
    filetype = {
        dart = {
          -- dart format
          function()
              return{
                exe = "dart format",
                args = {"--fix"},
                stdin = true,
            }
          end
        },
    }
  })

  -- format on save
  vim.api.nvim_exec([[
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost  FormatWrite
  augroup END
  ]], true)

EOF
nnoremap <leader>fm :Format<cr>

" vsnip
" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" numb nvim settings
lua require('numb').setup()

" dart settings
augroup dartrun
    autocmd!
    autocmd filetype dart nnoremap <silent><leader>rr :w \| belowright 13split \| terminal dart --enable-asserts run <C-r>\%<Cr>i
augroup END

" Run chezmoi apply whenever I save a dotfile
autocmd BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path %
