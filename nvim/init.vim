" --- !!! [I am using vim-plug as my plugin manager] !!! ---
set nu
set encoding=UTF-8

" ------------------- [Plugins] ---------------------
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'

call plug#end()
" --------------- [End of Plugins] ------------------

" ----------- [Gruvbox related things] --------------
" autocmd VimEnter * hi Nermal ctermbg=none 
" let g:gruvbox_transparent_bg = '1'
" Tried to get transparent background to work but it doesn't work :(
colorscheme gruvbox
" ------- [End of Gruvbox related things] ----------- 

" --------- [Airline retated things] ----------------
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
" on my computer the fonts are a lil messed up, hopefully i can fix that soon
" ---------- [End of airline things] ----------------
filetype plugin indent on

