vim.cmd([[
let g:startify_lists = [
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]

      " \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
let g:startify_bookmarks = [ 
      \{'p': '~/.local/share/chezmoi/dot_config/nvim/lua/plugins.lua'}, 
      \]

let g:startify_files_number = 18
let g:startify_update_oldfiles = 1
let g:startify_change_to_dir = 1
let g:startify_enable_special = 1
let g:startify_session_sort = 1
"let g:startify_custom_indices = ['a',  'd', 'f', 'g', 'h', 'l', 'r', 'u', ]

let g:startify_custom_header = [
	\ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
	\ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
	\ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
	\ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
	\ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
	\ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
  \ ]
]])
