local map = vim.api.nvim_set_keymap
local opts = 'afada'
local sopts = 'afada'

-- keep cursor in center of screen when transversing search
map( "n", "n", "nzzzv", opts )
map( "n", "N", "Nzzzv", opts )
map( "n", "J", "mzJ'z", opts )

-- add undo break points whenever certain characters are pressed
map( "i", ",", [[,<c-g>u]], opts )
map( "i", ".", [[.<c-g>u]], opts )
map( "i", "!", [[!<c-g>u]], opts )
map( "i", "?", [[?<c-g>u]], opts )
map( "i", "_", [[_<c-g>u]], opts )
map( "i", "-", [[j-<c-g>u]], opts )

-- populate jumplist whenever I move upward or downward 5 lines and above
map(
  "n", "k", [[(v:count > 4 ? "m'" . v:count : "") . 'k']], opts, { expr = true }
 )
map(
  "n", "j", [[(v:count > 4 ? "m'" . v:count : "") . 'j']], opts, { expr = true }
 )

-- mapping for moving line(s) in normal, insert and visual modes.
map( "v", "J", [[:m '>+1<cr>gv=gv]], opts )
map( "v", "K", [[:m '<-2<cr>gv=gv]], opts )
map( "n", "<leader>k", [[ <esc>:m .-2<cr>== ]] )
map( "n", "<leader>j", [[ <esc>:m .+1<cr>== ]] )

-- yank from cursor to eol
map( "n", "Y", "y$", opts )

-- map <leader>sv to source my vimrc file
map( "n", "<leader>sv", [[:source $MYVIMRC<cr>]], opts )

-- press ctrl l to go to the end of line in insert mode
map( "i", "<c-l>", "<c-o>A", opts )

-- use jk to go to normal mode from insert mode
map( "i", "jk", "<esc>", opts )

-- terminal mode mapping
map( "t", "jk", [[<c-\>'c-n']], opts )
map( "t", "<c-h>", [[<backspace>]], opts )

-- use <leader>ww to write files
map( "n", "<leader>ww", [[:write<cr>]], sopts )
map( "n", "<leader>wq", [[:exit<cr>]], sopts )
map( "n", "<leader>bd", [[:bdelete<cr>]], sopts )

-- map <leader>ev to edit my vimrc file
vim.cmd(
  [[
 <silent><leader>ev :edit ~/.local/share/chezmoi/dot_config/nvim/init.vim<cr>
function EditVimrc()
    if winwidth('.') > 110
        :vs $MYVIMRC
    else
        :e $MYVIMRC
    endif
endfuncti
]]
 )

-- map <leader>; to add delimiter to end of line.
vim.cmd(
  [[
"map <leader>; to add delimiter to end of line.
nnoremap <leader>; :call SemiColonDelimiter()<cr>
nnoremap <leader>, :call CommaDelimiter()<cr>

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
]]
 )

-- flutter and dart mappings
vim.cmd(
  [[
" flutter mappings
augroup flutterMappings
    autocmd!
    autocmd filetype dart nnoremap <buffer><silent><leader>rr :w \| belowright 13split \| terminal dart --enable-asserts run <C-r>\%<Cr>i
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
]]
 )

-- chezmoi apply
vim.cmd(
  [[
augroup chezmoiApply
    autocmd!
    autocmd BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path %
augroup END
 ]]
 )
