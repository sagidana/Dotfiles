""" ---- Vundle configuration ----  

filetype off

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')
"
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


""" ---- Plugins start here ----

" Surround operator
Plugin 'tpope/vim-surround'

" Indent text-object
Plugin 'michaeljsmith/vim-indent-object'

" File system view in tree form
" Documentation:
" https://vimawesome.com/plugin/nerdtree-red
Plugin 'scrooloose/nerdtree'

" Comment operator
" Documentation:
" https://vimawesome.com/plugin/the-nerd-commenter
Plugin 'scrooloose/nerdcommenter'

" Colorschemes
Plugin 'rakr/vim-one'

" Python completion
Plugin 'davidhalter/jedi-vim'

"Neovim Autocomplete
Plugin 'zchee/deoplete-jedi'

" Ctags management plugin
Plugin 'ludovicchabant/vim-gutentags'

" Cscope management plugin
Plugin 'brookhong/cscope.vim'


""" ---- Plugins end here ----

" All of your Plugins must be added before the following line
call vundle#end()


""" ---- General configuration ---- 

set nocompatible            " Disable compatibility to old-time vi
set showmatch               " Show matching brackets.
set hlsearch                " highlight search results
set tabstop=4               " number of columns occupied by a tab character
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set foldmethod=indent       " setting folding to indentations
set splitbelow              " the default split direction will be at the bottom

" allows auto-indenting depending on file type
filetype plugin indent on  

" Enable loading plugin file
filetype plugin on


""" ---- Colorscheme! ----

"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
	set termguicolors
  endif
endif


set background=dark " for the dark version
" set background=light " for the light version
colorscheme one


""" ---- General bindings ----
" Disable search highlights until next search at <esc> press.
nnoremap <esc> :noh<return><esc>


""" ---- Leader configuration ----
let mapleader = "\<space>"  " set leader as space

" Folding
nnoremap <leader>z0 :set foldlevel=0<cr>
nnoremap <leader>z1 :set foldlevel=1<cr>
nnoremap <leader>z2 :set foldlevel=2<cr>
nnoremap <leader>z3 :set foldlevel=3<cr>
nnoremap <leader>z4 :set foldlevel=4<cr>
nnoremap <leader>z5 :set foldlevel=5<cr>
nnoremap <leader>z6 :set foldlevel=6<cr>
nnoremap <leader>z7 :set foldlevel=7<cr>
nnoremap <leader>z8 :set foldlevel=8<cr>
nnoremap <leader>z9 :set foldlevel=9<cr>

" NerdTree toggle
nnoremap <leader>tt :NERDTreeToggle<cr>

" Cscope keybindings [cross-referrences]
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>





