local wk = require( "which-key" )

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
vim.api.nvim_set_keymap( "i", "-", [[-<c-g>u]], { noremap = true } )

-- populate jumplist whenever I move upward or downward 5 lines and above
vim.api.nvim_set_keymap( "n", "k", [[(v:count > 4 ? "m'" . v:count : "") . 'k']], { noremap = true, expr = true } )
vim.api.nvim_set_keymap( "n", "j", [[(v:count > 4 ? "m'" . v:count : "") . 'j']], { noremap = true, expr = true } )

-- mapping for moving line(s) in normal, insert and visual modes.
vim.api.nvim_set_keymap( "v", "J", [[:m '>+1<cr>gv=gv]], { noremap = true } )
vim.api.nvim_set_keymap( "v", "K", [[:m '<-2<cr>gv=gv]], { noremap = true } )
vim.api.nvim_set_keymap( "n", "<leader>k", [[ <esc>:m .-2<cr>== ]], { noremap = true } )
vim.api.nvim_set_keymap( "n", "<leader>j", [[ <esc>:m .+1<cr>== ]], { noremap = true } )

-- Visual shifting (does not exit Visual mode)
vim.api.nvim_set_keymap( 'v', '<', '<gv', { noremap = true, silent = true } )
vim.api.nvim_set_keymap( 'v', '>', '>gv', { noremap = true, silent = true } )

-- yank from cursor to eol
vim.api.nvim_set_keymap( "n", "Y", "y$", { noremap = true } )

-- map <leader>sv to source my vimrc file
-- vim.api.nvim_set_keymap( "n", "<leader>sv", [[:source $MYVIMRC<cr>]], { noremap = true } )

-- press ctrl e to go to the end of line in insert mode
vim.api.nvim_set_keymap( "i", "<c-e>", "<end>", { noremap = true } )
-- press ctrl b to go to the start of line in insert mode
vim.api.nvim_set_keymap( "i", "<c-b>", "<home>", { noremap = true } )
-- press ctrl j to go backwards in insert mode
vim.api.nvim_set_keymap( "i", "<c-j>", "<left>", { noremap = true } )
-- press ctrl k to go forwards in insert mode
vim.api.nvim_set_keymap( "i", "<c-k>", "<right>", { noremap = true } )
-- press ctrl u to go up in insert mode
vim.api.nvim_set_keymap( "i", "<c-u>", "<up>", { noremap = true } )
-- press ctrl d to go down in insert mode
vim.api.nvim_set_keymap( "i", "<c-d>", "<down>", { noremap = true } )

-- terminal mode mapping
vim.api.nvim_set_keymap( "t", "jk", [[<c-\><c-n>]], { noremap = true } )
vim.api.nvim_set_keymap( "t", "<c-h>", [[<backspace>]], { noremap = true } )

-- use <leader>ww to write files
vim.api.nvim_set_keymap( "n", "<leader>ww", ":write<cr>", { noremap = true, silent = true } )
vim.api.nvim_set_keymap( "n", "<leader>wq", [[:exit<cr>]], { noremap = true, silent = true } )
vim.api.nvim_set_keymap( "n", "<leader>bd", [[:bdelete<cr>]], { noremap = true, silent = true } )

-------------------------------------------------------------------------------------------------
-- Navigation
-------------------------------------------------------------------------------------------------
-- Zero should go to the first non-blank character not to the first column (which could be blank)
-- but if already at the first character then jump to the beginning
vim.api.nvim_set_keymap( 'n', '0', "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'",
                         { silent = true, noremap = true, expr = true } )
vim.api.nvim_set_keymap( 'x', '0', "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'",
                         { silent = true, noremap = true, expr = true } )
vim.api.nvim_set_keymap( 'o', '0', "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'",
                         { silent = true, noremap = true, expr = true } )
-- when going to the end of the line in visual mode ignore whitespace characters
vim.api.nvim_set_keymap( 'v', '$', 'g_', { noremap = true, silent = true } )

-- jk is escape, THEN move to the right to preserve the cursor position, unless at the first column.
vim.api.nvim_set_keymap( 'i', 'jk', [[col('.') == 1 ? '<esc>' : '<esc>l']], { expr = true } )

-- previous and next mappings
wk.register(
  { [']'] = { name = "Next", t = { "<cmd>tabnext<cr>", "Next Tab" }, b = { "<cmd>bnext<cr>", "Next Buffer" } } } )
wk.register( {
  ['['] = {
    name = "Previous",
    t = { "<cmd>tabprevious<cr>", "Previous Tab" },
    b = { "<cmd>bprevious<cr>", "Previous Buffer" },
  },
} )
-- Switch between the last two files
vim.api.nvim_set_keymap( 'n', '<leader><leader>', [[<c-^>]], { noremap = true, silent = true } )

-- split mappings
vim.api.nvim_set_keymap( "n", "<c-l>", "<c-w>l", { noremap = true, silent = true } )
vim.api.nvim_set_keymap( "n", "<c-h>", "<c-w>h", { noremap = true, silent = true } )
vim.api.nvim_set_keymap( "n", "<c-j>", "<c-w>j", { noremap = true, silent = true } )
vim.api.nvim_set_keymap( "n", "<c-k>", "<c-w>k", { noremap = true, silent = true } )
vim.api.nvim_set_keymap( "n", "_", "<c-w>s", { noremap = true, silent = true } )
vim.api.nvim_set_keymap( "n", "|", "<c-w>v", { noremap = true, silent = true } )
if vim.fn.bufwinnr( 1 ) then
  vim.api.nvim_set_keymap( 'n', '<s-l>', '<C-W>>', { noremap = true, silent = true } )
  vim.api.nvim_set_keymap( 'n', '<s-h>', '<C-W><', { noremap = true, silent = true } )
  vim.api.nvim_set_keymap( 'n', '-', '<C-W>-', { noremap = true, silent = true } )
  vim.api.nvim_set_keymap( 'n', '+', '<C-W>+', { noremap = true, silent = true } )
  vim.api.nvim_set_keymap( 'n', '=', '<C-W>=', { noremap = true, silent = true } )
end

-- map <leader>ev to edit my vimrc file
vim.cmd( [[
 nnoremap <silent><leader>ev :edit ~/.local/share/chezmoi/dot_config/nvim/init.lua<cr>
]] )

-- map <leader>; to add delimiter to end of line.
vim.cmd( [[
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
]] )
