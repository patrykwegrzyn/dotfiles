execute pathogen#infect()

autocmd FileType javascript set formatprg=prettier\ --stdin

set number
set ts=2 sts=2 noet

syntax on
colorscheme onedark 

set laststatus=2

if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

let g:ale_fixers = {
\   'javascript': ['eslint'],
\}

let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

let g:jsx_ext_required = 0

let g:completor_node_binary = '/usr/local/bin/node'

let g:prettier#config#bracket_spacing = 'true'
