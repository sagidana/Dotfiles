""" ---- Vundle configuration ----  

    filetyp off

    set rtp+=~/.config/nvim/bundle/Vundle.vim
    call vundle#begin('~/.config/nvim/bundle')

    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'

    """ ---- Plugins start here ----

        " Auto completion
        Plugin 'shougo/deoplete.nvim' 

        " Colorschemes
        Plugin 'rakr/vim-one'

        " Fuzzy finder files
        Plugin 'junegunn/fzf'

        " Table mode, for creating and modifying tables
        Plugin 'dhruvasagar/vim-table-mode'

    """ ---- Plugins end here ----

    " All of your Plugins must be added before the following line
    call vundle#end()


""" ---- General configuration ---- 

    set nocompatible            " Disable compatibility to old-time vi
    set showmatch               " Show matching brackets.
    set hlsearch                " highlight search results
    set incsearch               " highlight saerch results while searching.
    set inccommand=nosplit      " highlight search results while sustitude.
    set tabstop=4               " number of columns occupied by a tab character
    set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
    set expandtab               " converts tabs to white space
    set shiftwidth=4            " width for autoindents
    set autoindent              " indent a new line the same amount as the line just typed
    set number                  " add line numbers
    " set relativenumber          " setting relative numbers
    set foldmethod=indent       " setting folding to indentations
    set splitright              " split to the right.
    set splitbelow              " the default split direction will be at the bottom
    set mouse=a                 " enable mouse support (selection, resize).

    " allow file type detection
    filetype on

    " Enable loading plugin file
    filetype plugin on

    " allows auto-indenting depending on file type
    filetype plugin indent on  


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


""" ---- Table mode configuration ----

    " Send bindings to black hole!
    " Disabl default mappings used by the plugin.
    let g:table_mode_tableize_op_map='<F2>'
    let g:table_mode_tableize_map='<F2>'


""" ---- Deoplete Configuration ----

    " Enable deoplete.
    let g:deoplete#enable_at_startup = 1
    
    " Disable autocomplete
    call deoplete#custom#option('auto_complete', v:false)


""" ---- Netrw Configuration ----

    " Disable banner
    let g:netrw_banner = 0

    " Setting the width of the window to be 25%
    let g:netrw_winsize = 20

    " Setting the directroy view type.
    let g:netrw_liststyle = 3

    " Open selected in the brevious window
    let g:netrw_browse_split = 4


""" ---- Bindings ----

    " Disable search highlights until next search at <esc> press.
    nnoremap <esc> :noh<return><esc>

    " Bind tab to fold toggle.
    nnoremap <tab> za

    " Bind <C-i> to <M-o>
    nnoremap <M-o> <C-i>

    " CTRL-Space for manually auto complete
    inoremap <silent><expr> <C-Space> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<C-Space>" : deoplete#manual_complete()

    "" Deoplete binding helper function

        function! s:check_back_space() abort "{{{
            let col = col('.') - 1
            return !col || getline('.')[col - 1]  =~ '\s'
        endfunction"}}}

    " Navigation
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>

    nnoremap <M-j> 5j
    nnoremap <M-k> 5k
    vnoremap <M-j> 5j
    vnoremap <M-k> 5k

    """ --- Netrw Configuration ---

        " Making tab open folders instead of Enter
        autocmd filetype netrw nmap <buffer> <TAB> <CR>

    """ --- Leader configuration ---

        let mapleader = "\<space>"  " set leader as space

        " -- Evlauate commands

            " [Evaluate Config] Evaluating the vimrc
            nnoremap <leader>ec :source $MYVIMRC<CR>
            
        " -- Open commands
            
            " [Open Config] Opening the init.vim
            nnoremap <leader>oc :vsplit $MYVIMRC<CR>
            
        " -- Folding commands --
        
            nnoremap <leader>z0 :set foldlevel=0<CR>
            nnoremap <leader>z1 :set foldlevel=1<CR>
            nnoremap <leader>z2 :set foldlevel=2<CR>
            nnoremap <leader>z3 :set foldlevel=3<CR>
            nnoremap <leader>z4 :set foldlevel=4<CR>
            nnoremap <leader>z5 :set foldlevel=5<CR>
            nnoremap <leader>z6 :set foldlevel=6<CR>
            nnoremap <leader>z7 :set foldlevel=7<CR>
            nnoremap <leader>z8 :set foldlevel=8<CR>
            nnoremap <leader>z9 :set foldlevel=9<CR>

        " -- Toggle commands --

            " [Toggle Netrw]
            nnoremap <leader>tn :Lexplore<CR>
        
            " [Toggle Table Mode] TableMode toggle!
            nnoremap <leader>tm :TableModeToggle<CR>

        " -- Search commands --
           
            " [Search File] 
            nnoremap <leader>sf :FZF<CR>

        " -- Buffer commands --
            
            " [Buffer Before] Change to previous buffer
            nnoremap <leader>bb :bp<CR>

    """ --- Custom Operators Bindings ---
        
        " -- Surround Operator

            nnoremap <silent> cs :call <SID>SurroundOperator()<cr>

        " -- Comment Operator

            nnoremap <silent> gc :<C-u>set operatorfunc=<SID>CommentOperator<CR>g@
            vnoremap <silent> gc :<C-u>call <SID>CommentOperator(visualmode())<CR>

            " " Support count but not <SID>
            " nnoremap <expr> gc <SID>SetCommentOperator()
            " vnoremap <expr> <silent> gc <SID>SetCommentOperator()
        
    """ --- Custom Text Objects Bindings ---

        " -- Indent Text Object

            " Text Object Selection

                onoremap <silent> ii :<c-u>call <SID>InnerOuterIndentTextObject(v:count)<cr>
                onoremap <silent> ai :<c-u>call <SID>InnerOuterIndentTextObject(v:count)<cr>

                vnoremap <silent> ii :<c-u>call <SID>InnerOuterIndentTextObject(v:count)<cr>
                vnoremap <silent> ai :<c-u>call <SID>InnerOuterIndentTextObject(v:count)<cr>

        " -- Python Text Objects
            
            " Python for loop text object

                let g:python_for_pattern = 'for .*[:\\]$'

                " Motion

                    autocmd FileType python nnoremap <buffer> <silent> <M-r> :<c-u>call <SID>NormalMovePyTextObject(g:python_for_pattern, 1, v:count)<cr>
                    autocmd FileType python onoremap <buffer> <silent> <M-r> :call <SID>OperPendPyTextObject(g:python_for_pattern, 1, v:count)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> <M-r> :<c-u>call <SID>VisualMovePyTextObject(g:python_for_pattern, 1, v:count)<cr>

                    autocmd FileType python nnoremap <buffer> <silent> <M-R> :<c-u>call <SID>NormalMovePyTextObject(g:python_for_pattern, 0, v:count)<cr>
                    autocmd FileType python onoremap <buffer> <silent> <M-R> :call <SID>OperPendPyTextObject(g:python_for_pattern, 0, v:count)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> <M-R> :<c-u>call <SID>VisualMovePyTextObject(g:python_for_pattern, 0, v:count)<cr>

                " Text Object Selection

                    autocmd FileType python onoremap <buffer> <silent> ir :<c-u>call <SID>InnerOuterPyTextObject(g:python_for_pattern, v:count, 1)<cr>
                    autocmd FileType python onoremap <buffer> <silent> ar :<c-u>call <SID>InnerOuterPyTextObject(g:python_for_pattern, v:count, 0)<cr>

                    autocmd FileType python vnoremap <buffer> <silent> ir :<c-u>call <SID>InnerOuterPyTextObject(g:python_for_pattern, v:count, 1)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> ar :<c-u>call <SID>InnerOuterPyTextObject(g:python_for_pattern, v:count, 0)<cr>

                    autocmd FileType python onoremap <buffer> <silent> iR :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_for_pattern, v:count, 1)<cr>
                    autocmd FileType python onoremap <buffer> <silent> aR :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_for_pattern, v:count, 0)<cr>

                    autocmd FileType python vnoremap <buffer> <silent> iR :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_for_pattern, v:count, 1)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> aR :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_for_pattern, v:count, 0)<cr>

            " Python while loop text object

                let g:python_while_pattern = 'while .*:$'

                " Motion

                    autocmd FileType python nnoremap <buffer> <silent> <M-e> :<c-u>call <SID>NormalMovePyTextObject(g:python_while_pattern, 1, v:count)<cr>
                    autocmd FileType python onoremap <buffer> <silent> <M-e> :call <SID>OperPendPyTextObject(g:python_while_pattern, 1, v:count)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> <M-e> :<c-u>call <SID>VisualMovePyTextObject(g:python_while_pattern, 1, v:count)<cr>

                    autocmd FileType python nnoremap <buffer> <silent> <M-E> :<c-u>call <SID>NormalMovePyTextObject(g:python_while_pattern, 0, v:count)<cr>
                    autocmd FileType python onoremap <buffer> <silent> <M-E> :call <SID>OperPendPyTextObject(g:python_while_pattern, 0, v:count)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> <M-E> :<c-u>call <SID>VisualMovePyTextObject(g:python_while_pattern, 0, v:count)<cr>

                " Text Object Selection

                    autocmd FileType python onoremap <buffer> <silent> ie :<c-u>call <SID>InnerOuterPyTextObject(g:python_while_pattern, v:count, 1)<cr>
                    autocmd FileType python onoremap <buffer> <silent> ae :<c-u>call <SID>InnerOuterPyTextObject(g:python_while_pattern, v:count, 0)<cr>

                    autocmd FileType python vnoremap <buffer> <silent> ie :<c-u>call <SID>InnerOuterPyTextObject(g:python_while_pattern, v:count, 1)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> ae :<c-u>call <SID>InnerOuterPyTextObject(g:python_while_pattern, v:count, 0)<cr>

                    autocmd FileType python onoremap <buffer> <silent> iE :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_while_pattern, v:count, 1)<cr>
                    autocmd FileType python onoremap <buffer> <silent> aE :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_while_pattern, v:count, 0)<cr>

                    autocmd FileType python vnoremap <buffer> <silent> iE :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_while_pattern, v:count, 1)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> aE :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_while_pattern, v:count, 0)<cr>

            " Python if statement text object

                let g:python_if_pattern = 'if .*[:\\]$'

                " Motion

                    autocmd FileType python nnoremap <buffer> <silent> <M-f> :<c-u>call <SID>NormalMovePyTextObject(g:python_if_pattern, 1, v:count)<cr>
                    autocmd FileType python onoremap <buffer> <silent> <M-f> :call <SID>OperPendPyTextObject(g:python_if_pattern, 1, v:count)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> <M-f> :<c-u>call <SID>VisualMovePyTextObject(g:python_if_pattern, 1, v:count)<cr>

                    autocmd FileType python nnoremap <buffer> <silent> <M-F> :<c-u>call <SID>NormalMovePyTextObject(g:python_if_pattern, 0, v:count)<cr>
                    autocmd FileType python onoremap <buffer> <silent> <M-F> :call <SID>OperPendPyTextObject(g:python_if_pattern, 0, v:count)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> <M-F> :<c-u>call <SID>VisualMovePyTextObject(g:python_if_pattern, 0, v:count)<cr>

                " Text Object Selection

                    autocmd FileType python onoremap <buffer> <silent> if :<c-u>call <SID>InnerOuterPyTextObject(g:python_if_pattern, v:count, 1)<cr>
                    autocmd FileType python onoremap <buffer> <silent> af :<c-u>call <SID>InnerOuterPyTextObject(g:python_if_pattern, v:count, 0)<cr>

                    autocmd FileType python vnoremap <buffer> <silent> if :<c-u>call <SID>InnerOuterPyTextObject(g:python_if_pattern, v:count, 1)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> af :<c-u>call <SID>InnerOuterPyTextObject(g:python_if_pattern, v:count, 0)<cr>

                    autocmd FileType python onoremap <buffer> <silent> iF :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_if_pattern, v:count, 1)<cr>
                    autocmd FileType python onoremap <buffer> <silent> aF :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_if_pattern, v:count, 0)<cr>

                    autocmd FileType python vnoremap <buffer> <silent> iF :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_if_pattern, v:count, 1)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> aF :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_if_pattern, v:count, 0)<cr>

            " Python try statement text object

                let g:python_try_pattern = 'try:$'

                " Motion

                    autocmd FileType python nnoremap <buffer> <silent> <M-y> :<c-u>call <SID>NormalMovePyTextObject(g:python_try_pattern, 1, v:count)<cr>
                    autocmd FileType python onoremap <buffer> <silent> <M-y> :call <SID>OperPendPyTextObject(g:python_try_pattern, 1, v:count)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> <M-y> :<c-u>call <SID>VisualMovePyTextObject(g:python_try_pattern, 1, v:count)<cr>

                    autocmd FileType python nnoremap <buffer> <silent> <M-Y> :<c-u>call <SID>NormalMovePyTextObject(g:python_try_pattern, 0, v:count)<cr>
                    autocmd FileType python onoremap <buffer> <silent> <M-Y> :call <SID>OperPendPyTextObject(g:python_try_pattern, 0, v:count)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> <M-Y> :<c-u>call <SID>VisualMovePyTextObject(g:python_try_pattern, 0, v:count)<cr>

                " Text Object Selection

                    autocmd FileType python onoremap <buffer> <silent> iy :<c-u>call <SID>InnerOuterPyTextObject(g:python_try_pattern, v:count, 1)<cr>
                    autocmd FileType python onoremap <buffer> <silent> ay :<c-u>call <SID>InnerOuterPyTextObject(g:python_try_pattern, v:count, 0)<cr>

                    autocmd FileType python vnoremap <buffer> <silent> iy :<c-u>call <SID>InnerOuterPyTextObject(g:python_try_pattern, v:count, 1)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> ay :<c-u>call <SID>InnerOuterPyTextObject(g:python_try_pattern, v:count, 0)<cr>

                    autocmd FileType python onoremap <buffer> <silent> iY :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_try_pattern, v:count, 1)<cr>
                    autocmd FileType python onoremap <buffer> <silent> aY :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_try_pattern, v:count, 0)<cr>

                    autocmd FileType python vnoremap <buffer> <silent> iY :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_try_pattern, v:count, 1)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> aY :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_try_pattern, v:count, 0)<cr>

            " Python else statement text object

                let g:python_else_pattern = '(else:|elif .*[:\\]$)'

                " Motion

                    autocmd FileType python nnoremap <buffer> <silent> <M-l> :<c-u>call <SID>NormalMovePyTextObject(g:python_else_pattern, 1, v:count)<cr>
                    autocmd FileType python onoremap <buffer> <silent> <M-l> :call <SID>OperPendPyTextObject(g:python_else_pattern, 1, v:count)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> <M-l> :<c-u>call <SID>VisualMovePyTextObject(g:python_else_pattern, 1, v:count)<cr>

                    autocmd FileType python nnoremap <buffer> <silent> <M-L> :<c-u>call <SID>NormalMovePyTextObject(g:python_else_pattern, 0, v:count)<cr>
                    autocmd FileType python onoremap <buffer> <silent> <M-L> :call <SID>OperPendPyTextObject(g:python_else_pattern, 0, v:count)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> <M-L> :<c-u>call <SID>VisualMovePyTextObject(g:python_else_pattern, 0, v:count)<cr>

                " Text Object Selection

                    autocmd FileType python onoremap <buffer> <silent> il :<c-u>call <SID>InnerOuterPyTextObject(g:python_else_pattern, v:count, 1)<cr>
                    autocmd FileType python onoremap <buffer> <silent> al :<c-u>call <SID>InnerOuterPyTextObject(g:python_else_pattern, v:count, 0)<cr>

                    autocmd FileType python vnoremap <buffer> <silent> il :<c-u>call <SID>InnerOuterPyTextObject(g:python_else_pattern, v:count, 1)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> al :<c-u>call <SID>InnerOuterPyTextObject(g:python_else_pattern, v:count, 0)<cr>

                    autocmd FileType python onoremap <buffer> <silent> iL :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_else_pattern, v:count, 1)<cr>
                    autocmd FileType python onoremap <buffer> <silent> aL :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_else_pattern, v:count, 0)<cr>

                    autocmd FileType python vnoremap <buffer> <silent> iL :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_else_pattern, v:count, 1)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> aL :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_else_pattern, v:count, 0)<cr>
                    
            " Python class text object

                let g:python_class_pattern = 'class .*:$'

                " Motion

                    autocmd FileType python nnoremap <buffer> <silent> <M-s> :<c-u>call <SID>NormalMovePyTextObject(g:python_class_pattern, 1, v:count)<cr>
                    autocmd FileType python onoremap <buffer> <silent> <M-s> :call <SID>OperPendPyTextObject(g:python_class_pattern, 1, v:count)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> <M-s> :<c-u>call <SID>VisualMovePyTextObject(g:python_class_pattern, 1, v:count)<cr>

                    autocmd FileType python nnoremap <buffer> <silent> <M-S> :<c-u>call <SID>NormalMovePyTextObject(g:python_class_pattern, 0, v:count)<cr>
                    autocmd FileType python onoremap <buffer> <silent> <M-S> :call <SID>OperPendPyTextObject(g:python_class_pattern, 0, v:count)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> <M-S> :<c-u>call <SID>VisualMovePyTextObject(g:python_class_pattern, 0, v:count)<cr>

                " Text Object Selection

                    autocmd FileType python onoremap <buffer> <silent> ic :<c-u>call <SID>InnerOuterPyTextObject(g:python_class_pattern, v:count, 1)<cr>
                    autocmd FileType python onoremap <buffer> <silent> ac :<c-u>call <SID>InnerOuterPyTextObject(g:python_class_pattern, v:count, 0)<cr>

                    autocmd FileType python vnoremap <buffer> <silent> ic :<c-u>call <SID>InnerOuterPyTextObject(g:python_class_pattern, v:count, 1)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> ac :<c-u>call <SID>InnerOuterPyTextObject(g:python_class_pattern, v:count, 0)<cr>

                    autocmd FileType python onoremap <buffer> <silent> iC :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_class_pattern, v:count, 1)<cr>
                    autocmd FileType python onoremap <buffer> <silent> aC :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_class_pattern, v:count, 0)<cr>

                    autocmd FileType python vnoremap <buffer> <silent> iC :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_class_pattern, v:count, 1)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> aC :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_class_pattern, v:count, 0)<cr>

            " Python method/function text object

                let g:python_method_pattern = 'def .*:$'

                " Motion

                    autocmd FileType python nnoremap <buffer> <silent> <M-m> :<c-u>call <SID>NormalMovePyTextObject(g:python_method_pattern, 1, v:count)<cr>
                    autocmd FileType python onoremap <buffer> <silent> <M-m> :call <SID>OperPendPyTextObject(g:python_method_pattern, 1, v:count)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> <M-m> :<c-u>call <SID>VisualMovePyTextObject(g:python_method_pattern, 1, v:count)<cr>

                    autocmd FileType python nnoremap <buffer> <silent> <M-M> :<c-u>call <SID>NormalMovePyTextObject(g:python_method_pattern, 0, v:count)<cr>
                    autocmd FileType python onoremap <buffer> <silent> <M-M> :call <SID>OperPendPyTextObject(g:python_method_pattern, 0, v:count)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> <M-M> :<c-u>call <SID>VisualMovePyTextObject(g:python_method_pattern, 0, v:count)<cr>

                " Text Object Selection

                    autocmd FileType python onoremap <buffer> <silent> im :<c-u>call <SID>InnerOuterPyTextObject(g:python_method_pattern, v:count, 1)<cr>
                    autocmd FileType python onoremap <buffer> <silent> am :<c-u>call <SID>InnerOuterPyTextObject(g:python_method_pattern, v:count, 0)<cr>

                    autocmd FileType python vnoremap <buffer> <silent> im :<c-u>call <SID>InnerOuterPyTextObject(g:python_method_pattern, v:count, 1)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> am :<c-u>call <SID>InnerOuterPyTextObject(g:python_method_pattern, v:count, 0)<cr>

                    autocmd FileType python onoremap <buffer> <silent> iM :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_method_pattern, v:count, 1)<cr>
                    autocmd FileType python onoremap <buffer> <silent> aM :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_method_pattern, v:count, 0)<cr>

                    autocmd FileType python vnoremap <buffer> <silent> iM :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_method_pattern, v:count, 1)<cr>
                    autocmd FileType python vnoremap <buffer> <silent> aM :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_method_pattern, v:count, 0)<cr>


""" ---- Custom Plugins ----

    " --- Operators ---

        " -- Surround Operator Implementation

            function! s:GetSidesSurroundOperator(character)
                if a:character ==# "'"
                    return ["'", "'"]
                elseif a:character ==# '"'
                    return ['"', '"']
                elseif a:character ==# '(' || a:character ==# ')'
                    return ['(', ')']
                elseif a:character ==# '[' || a:character ==# ']'
                    return ['[', ']']
                elseif a:character ==# '{' || a:character ==# '}'
                    return ['{', '}']
                elseif a:character ==# '<' || a:character ==# '>'
                    return ['<', '>']
                elseif a:character ==# '`'
                    return ['`', '`']
                elseif a:character ==# '/'
                    return ['/', '/']
                else
                    return [-1, -1]
                endif
            endfunction

            function! s:SurroundOperator()
                " Get the character to change
                let l:before_character = nr2char(getchar())

                let l:left_before_character = <SID>GetSidesSurroundOperator(l:before_character)[0]
                let l:right_before_character = <SID>GetSidesSurroundOperator(l:before_character)[1]
                if l:left_before_character ==# -1
                    return
                endif

                let l:current_line = getline(line('.'))

                let l:left_side_of_line = l:current_line[:col('.') - 1]
                let l:right_side_of_line = l:current_line[col('.'):]

                if match(l:right_side_of_line, '^.*'.l:right_before_character.'.*$') < 0
                    return
                endif

                if match(l:left_side_of_line, '^.*'.l:left_before_character.'.*$') < 0
                    return
                endif

                " Get the character to change with
                let l:after_character = nr2char(getchar())

                let l:left_after_character = <SID>GetSidesSurroundOperator(l:after_character)[0]
                let l:right_after_character = <SID>GetSidesSurroundOperator(l:after_character)[1]

                if l:left_after_character ==# -1
                    return
                endif

                " Handle the right side
                if l:current_line[col('.')] ==# l:right_before_character
                    execute "silent! normal! "."r".l:right_after_character
                else
                    execute "silent! normal! "."f".l:right_before_character."r".l:right_after_character
                endif

                " Handle the left side
                execute "silent! normal! "."F".l:left_before_character."r".l:left_after_character
            endfunction

        " -- Comment Operator Implementation

            function! s:GetCommentSyntaxCommentOperator()
                " default will be //
                let l:comment_syntax = "//"
                
                if &filetype ==# 'python'
                    let l:comment_syntax = "#"
                elseif &filetype ==# 'vim'
                    let l:comment_syntax = "\""
                endif

                return l:comment_syntax
            endfunction

            function! s:CommentLineCommentOperator(lnum)
                let l:line = getline(a:lnum)

                " If empty line don't comment
                if match(l:line, "^\\s*$") >= 0
                    return
                endif

                let l:comment = <SID>GetCommentSyntaxCommentOperator()

                if indent(a:lnum) ==# 0
                    let l:line = l:comment." ".l:line
                else
                    let l:line = l:line[:indent(a:lnum) - 1].l:comment." ".l:line[indent(a:lnum):]
                endif
                cal setline(a:lnum, l:line)
            endfunction

            function! s:UncommentLineCommentOperator(lnum)
                let l:line = getline(a:lnum)
                let l:comment = <SID>GetCommentSyntaxCommentOperator()
                let l:comment_pattern_1 = l:comment."\\s"
                let l:comment_pattern_2 = l:comment."\\w\\+"

                let l:found_index_pattern_1 = match(l:line, l:comment_pattern_1) 
                let l:found_index_pattern_2 = match(l:line, l:comment_pattern_2) 

                if l:found_index_pattern_1 < 0
                    let l:found_index_pattern_1 = 999
                endif

                if l:found_index_pattern_2 < 0
                    let l:found_index_pattern_2 = 999
                endif

                if l:found_index_pattern_1 < l:found_index_pattern_2
                    let l:found_index = match(l:line, l:comment_pattern_1)

                    if l:found_index ==# 0
                        let l:line = l:line[2:]
                    elseif l:found_index > 0
                        let l:line = l:line[:l:found_index - 1].l:line[l:found_index + 2:]
                    endif
                else
                    let l:found_index = match(l:line, l:comment_pattern_2)

                    if l:found_index ==# 0
                        let l:line = l:line[1:]
                    elseif l:found_index > 0
                        let l:line = l:line[:l:found_index - 1].l:line[l:found_index + 1:]
                    endif
                endif

                cal setline(a:lnum, l:line)
            endfunction

            function! s:CheckIfCommentedCommentOperator(start_range, end_range)
                " Check if all lines already commented
                let l:to_comment = 0
                let l:current_line = line(a:start_range)
                let l:end_line = line(a:end_range)
                while l:current_line <= l:end_line
                    let l:line = getline(l:current_line)

                    " Ignore empty lines
                    if match(l:line, "^\\s*$") >= 0
                        break
                    endif

                    if match(l:line, "^\\s*".<SID>GetCommentSyntaxCommentOperator().".*$") < 0
                        let l:to_comment = 1
                        break
                    endif
                    let l:current_line = l:current_line + 1
                endwhile

                return l:to_comment
            endfunction

            function! s:CommentLinesCommentOperator(start_range, end_range)
                let l:current_line = line(a:start_range)
                let l:end_line = line(a:end_range)

                while l:current_line <= l:end_line
                    call <SID>CommentLineCommentOperator(l:current_line)

                    let l:current_line = l:current_line + 1
                endwhile
            endfunction

            function! s:UncommentLinesCommentOperator(start_range, end_range)
                let l:current_line = line(a:start_range)
                let l:end_line = line(a:end_range)

                while l:current_line <= l:end_line
                    call <SID>UncommentLineCommentOperator(l:current_line)

                    let l:current_line = l:current_line + 1
                endwhile
            endfunction

            function! s:MainCommentOperator(start_range, end_range)
                let l:to_comment = <SID>CheckIfCommentedCommentOperator(a:start_range, a:end_range)

                " Exit if no commenting needed.
                if l:to_comment ==# 0
                    call <SID>UncommentLinesCommentOperator(a:start_range, a:end_range)
                else
                    call <SID>CommentLinesCommentOperator(a:start_range, a:end_range)
                endif
            endfunction

            function! s:CommentOperator(type)
                " Save unnamed register's content
                let l:saved_unnamed_register = @@

                if a:type ==# 'v'
                    let l:start_range = "'<"
                    let l:end_range = "'>"

                    call <SID>MainCommentOperator(l:start_range, l:end_range)
                elseif a:type ==# 'V'
                    let l:start_range = "'<"
                    let l:end_range = "'>"

                    call <SID>MainCommentOperator(l:start_range, l:end_range)
                elseif a:type ==# "\<c-v>"                          " Visuall Block mode
                    let l:start_range = "'<"
                    let l:end_range = "'>"

                    call <SID>MainCommentOperator(l:start_range, l:end_range)
                elseif a:type ==# 'line'
                    let l:start_range = "'["
                    let l:end_range = "']"

                    call <SID>MainCommentOperator(l:start_range, l:end_range)
                elseif a:type ==# 'char'
                    let l:start_range = "'["
                    let l:end_range = "']"

                    call <SID>MainCommentOperator(l:start_range, l:end_range)
                endif

                " Restore unnamed register's content
                let @@ = l:saved_unnamed_register 
            endfunction

            function! s:SetCommentOperator()
                set operatorfunc=<SID>CommentOperator
                return 'g@'
            endfunction

            " Bindings Examples

                " nnoremap <silent> gc :<C-u>set operatorfunc=<SID>CommentOperator<CR>g@
                " vnoremap <silent> gc :<C-u>call <SID>CommentOperator(visualmode())<CR>

                " " " Support count but not <SID>
                " " nnoremap <expr> gc <SID>SetCommentOperator()
                " " vnoremap <expr> <silent> gc <SID>SetCommentOperator()

    " --- Text Objects ---

        " -- Indent Text Object

            function! s:InnerOuterIndentTextObject(count)
                let l:indent_level = indent(line("."))
                if l:indent_level ==# 0
                    return
                endif

                " Go up to start of indentation.
                while 1
                    if indent(line(".")) < l:indent_level && match(getline(line(".")), "^\\s*$") < 0 
                        break
                    endif

                    execute "silent! normal! k"
                endwhile

                execute "silent! normal! j"

                " Keep down until not an empty line
                while match(getline(line(".")), "^\\s*$") > -1
                    execute "silent! normal! j"
                endwhile
                
                " Start viusal-line-mode
                let l:command = "V"

                execute "silent! normal! ".l:command

                " Keep down until indentation no longer fit
                let l:inner_indent_level = indent(line("."))

                let l:is_end_of_file = 0
                while 1
                    execute "silent! normal! j"
                    let l:inner_indent_level = indent(line("."))

                    " Check if end of file
                    if line(".") ==# line("$")
                        let l:is_end_of_file = 1
                        break
                    endif

                    if l:inner_indent_level < l:indent_level
                        if match(getline(line(".")), "^\\s*$") < 0
                            break
                        endif
                    endif
                endwhile

                if l:is_end_of_file ==# 0
                    execute "silent! normal! k"
                endif

                " Keep up until not an empty line
                while match(getline(line(".")), "^\\s*$") > -1
                    execute "silent! normal! k"
                endwhile
            endfunction

        " -- Python Text Objects

            function! s:NormalMovePyTextObject(python_statement_pattern, to_next, count)
                " Save the user's wrapscan settings.
                let l:saved_wrapscan = &wrapscan

                let &wrapscan = 0

                let l:direction = '/'
                if a:to_next ==# 0
                    let l:direction = '?'
                endif

                execute "silent! normal! ".l:direction.'\v'.a:python_statement_pattern."\r"

                " Repeat the search \<count\> times.
                execute "silent! normal! ".repeat("n", a:count - 1)
                
                " Return the user's wrapscan settings.
                let &wrapscan=l:saved_wrapscan
            endfunction

            function! s:VisualMovePyTextObject(python_statement_pattern, to_next, count)
                normal! gv
                call <SID>NormalMovePyTextObject(a:python_statement_pattern, a:to_next, a:count)
            endfunction

            function! s:OperPendPyTextObject(python_statement_pattern, to_next, count)
                normal! v
                call NormalMovePyTextObject(a:python_statement_pattern, a:to_next, a:count)
                normal! k$
            endfunction

            function! s:InnerOuterPyTextObject(python_statement_pattern, count, is_inner)
                " Save the user's wrapscan settings.
                let l:saved_wrapscan = &wrapscan

                let &wrapscan = 0

                execute "silent! normal! l"

                " Got to previous for decleration
                execute "silent! normal! ".'?\v'.a:python_statement_pattern."\r"

                let l:indent_level = indent(line("."))

                let l:command = "jV"
                if a:is_inner ==# 0
                    let l:command = "Vj"
                endif
                execute "silent! normal! ".l:command

                " Keep down until indentation no longer fit
                let l:inner_indent_level = indent(line("."))

                let l:is_end_of_file = 0
                while 1
                    execute "silent! normal! j"
                    let l:inner_indent_level = indent(line("."))

                    " Check if end of file
                    if line(".") ==# line("$")
                        let l:is_end_of_file = 1
                        break
                    endif

                    if l:inner_indent_level <= l:indent_level
                        if match(getline(line(".")), "^\\s*$") < 0
                            break
                        endif
                    endif
                endwhile

                if l:is_end_of_file ==# 0
                    execute "silent! normal! k"
                endif

                " Keep up until not an empty line
                while match(getline(line(".")), "^\\s*$") > -1
                    execute "silent! normal! k"
                endwhile

                " Return the user's wrapscan settings.
                let &wrapscan=l:saved_wrapscan
            endfunction

            function! s:InnerOuterStatementPyTextObject(python_statement_pattern, count, is_inner)
                " Save the user's wrapscan settings.
                let l:saved_wrapscan = &wrapscan

                let &wrapscan = 0
                execute "silent! normal! l"

                " Got to previous for decleration
                execute "silent! normal! ".'?\v'.a:python_statement_pattern."\r"

                if a:is_inner ==# 1
                    execute "silent! normal! "."w"
                endif

                execute "silent! normal! "."v/:\rh"

                " Return the user's wrapscan settings.
                let &wrapscan=l:saved_wrapscan
            endfunction
                        
            " Bindings Examples

                " let g:python_for_pattern = 'for .*[:\\]$'

                " " Motion

                    " autocmd FileType python nnoremap <buffer> <silent> <M-r> :<c-u>call <SID>NormalMovePyTextObject(g:python_for_pattern, 1, v:count)<cr>
                    " autocmd FileType python onoremap <buffer> <silent> <M-r> :call <SID>OperPendPyTextObject(g:python_for_pattern, 1, v:count)<cr>
                    " autocmd FileType python vnoremap <buffer> <silent> <M-r> :<c-u>call <SID>VisualMovePyTextObject(g:python_for_pattern, 1, v:count)<cr>

                    " autocmd FileType python nnoremap <buffer> <silent> <M-R> :<c-u>call <SID>NormalMovePyTextObject(g:python_for_pattern, 0, v:count)<cr>
                    " autocmd FileType python onoremap <buffer> <silent> <M-R> :call <SID>OperPendPyTextObject(g:python_for_pattern, 0, v:count)<cr>
                    " autocmd FileType python vnoremap <buffer> <silent> <M-R> :<c-u>call <SID>VisualMovePyTextObject(g:python_for_pattern, 0, v:count)<cr>

                " " Text Object Selection

                    " autocmd FileType python onoremap <buffer> <silent> ir :<c-u>call <SID>InnerOuterPyTextObject(g:python_for_pattern, v:count, 1)<cr>
                    " autocmd FileType python onoremap <buffer> <silent> ar :<c-u>call <SID>InnerOuterPyTextObject(g:python_for_pattern, v:count, 0)<cr>

                    " autocmd FileType python vnoremap <buffer> <silent> ir :<c-u>call <SID>InnerOuterPyTextObject(g:python_for_pattern, v:count, 1)<cr>
                    " autocmd FileType python vnoremap <buffer> <silent> ar :<c-u>call <SID>InnerOuterPyTextObject(g:python_for_pattern, v:count, 0)<cr>

                    " autocmd FileType python onoremap <buffer> <silent> iR :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_for_pattern, v:count, 1)<cr>
                    " autocmd FileType python onoremap <buffer> <silent> aR :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_for_pattern, v:count, 0)<cr>

                    " autocmd FileType python vnoremap <buffer> <silent> iR :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_for_pattern, v:count, 1)<cr>
                    " autocmd FileType python vnoremap <buffer> <silent> aR :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_for_pattern, v:count, 0)<cr>
