-- keep cursor in center of screen when transversing search
vim.api.nvim_set_keymap( "n", "n", "nzzzv", { noremap = true } )
vim.api.nvim_set_keymap( "n", "N", "Nzzzv", { noremap = true } )
vim.api.nvim_set_keymap( "n", "J", "mzJ'z", { noremap = true } )

-- add undo break points whenever certain characters are pressed
vim.api.nvim_set_keymap( "i", ",", [[,<c-g>u]], { noremap = true } )
vim.api.nvim_set_keymap( "i", ".", [[.<c-g>u]], { noremap = true } )
vim.api.nvim_set_keymap( "i", "!", [[!<c-g>u]], { noremap = true } )
vim.api.nvim_set_keymap( "i", "?", [[?<c-g>u]], { noremap = true } )
vim.api.nvim_set_keymap( "i", "_", [[_<c-g>u]], { noremap = true } )
vim.api.nvim_set_keymap( "i", "-", [[j-<c-g>u]], { noremap = true } )

-- populate jumplist whenever I move upward or downward 5 lines and above
vim.api.nvim_set_keymap(
  "n", "k", [[(v:count > 4 ? "m'" . v:count : "") . 'k']],
  { noremap = true, expr = true }
 )
vim.api.nvim_set_keymap(
  "n", "j", [[(v:count > 4 ? "m'" . v:count : "") . 'j']],
  { noremap = true, expr = true }
 )

-- mapping for moving line(s) in normal, insert and visual modes.
vim.api.nvim_set_keymap( "v", "J", [[:m '>+1<cr>gv=gv]], { noremap = true } )
vim.api.nvim_set_keymap( "v", "K", [[:m '<-2<cr>gv=gv]], { noremap = true } )
vim.api.nvim_set_keymap( "n", "<leader>k", [[ <esc>:m .-2<cr>== ]] )
vim.api.nvim_set_keymap( "n", "<leader>j", [[ <esc>:m .+1<cr>== ]] )

-- yank from cursor to eol
vim.api.nvim_set_keymap( "n", "Y", "y$", { noremap = true } )

-- map <leader>sv to source my vimrc file
vim.api.nvim_set_keymap(
  "n", "<leader>sv", [[:source $MYVIMRC<cr>]], { noremap = true }
 )

-- press ctrl l to go to the end of line in insert mode
vim.api.nvim_set_keymap( "i", "<c-l>", "<c-o>A", { noremap = true } )

-- use jk to go to normal mode from insert mode
vim.api.nvim_set_keymap( "i", "jk", "<esc>", { noremap = true } )

-- terminal mode mapping
vim.api.nvim_set_keymap( "t", "jk", [[<c-\>'c-n']], { noremap = true } )
vim.api.nvim_set_keymap( "t", "<c-h>", [[<backspace>]], { noremap = true } )

-- use <leader>ww to write files
vim.api.nvim_set_keymap(
  "n", "<leader>ww", [[:write<cr>]], { noremap = true, silent = true }
 )
vim.api.nvim_set_keymap(
  "n", "<leader>wq", [[:exit<cr>]], { noremap = true, silent = true }
 )
vim.api.nvim_set_keymap(
  "n", "<leader>bd", [[:bdelete<cr>]], { noremap = true, silent = true }
 )

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