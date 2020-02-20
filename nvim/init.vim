""" ---- Vundle configuration ----  

    filetyp off
    if has("win32")
        set rtp+=$HOME/AppData/Local/nvim/bundle/Vundle.vim
        call vundle#begin('$HOME/AppData/Local/nvim/bundle')
    else
        set rtp+=~/.config/nvim/bundle/Vundle.vim
        call vundle#begin('~/.config/nvim/bundle')
    endif

    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'

    """ ---- Plugins start here ----


    """ ---- Plugins end here ----

    " All of your Plugins must be added before the following line
    call vundle#end()


""" ---- General configuration ---- 

    set nocompatible               " Disable compatibility to old-time vi
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
    set foldlevel=20            " unfold all folds by default
    set splitright              " split to the right.
    set splitbelow              " the default split direction will be at the bottom
    set mouse=a                 " enable mouse support (selection, resize).
    set tags=tags               " enable ctags
    set clipboard+=unnamedplus

    if has('cscope')
        set cscopetag 
        set nocscopeverbose
        set csto=1                  " check ctags before cscope

        if has('quickfix')
            set cscopequickfix=s-,c-,d-,i-,t-,e-
        endif

        "add any database in current dir
        if filereadable("cscope.out")
            cs add cscope.out
        endif
    endif

    " cursor visualization.
    set guicursor=n-v-c:block-blinkwait175-blinkoff150-blinkon175,i-ci-ve:ver25,r-cr:hor20,o:hor50

    " allow file type detection
    filetype on

    " Enable loading plugin file
    filetype plugin on

    " allows auto-indenting depending on file type
    filetype plugin indent on  


""" ---- Colorscheme! ----

    colorscheme default

    " set termguicolors
    " set background=dark 
    " colorscheme candid


""" ---- Bindings ----

    " Disable search highlights until next search at <esc> press.
    nnoremap <esc> :noh<return><esc>

    " Bind tab to fold toggle.
    nnoremap <tab> za

    " Bind <C-i> to <M-o>
    nnoremap <M-o> <C-i>

    " Resizing
    nnoremap <C-Up> :resize +6<CR>
    nnoremap <C-Down> :resize -6<CR>
    nnoremap <C-Right> :vertical resize +6<CR>
    nnoremap <C-Left> :vertical resize -6<CR>

    " Navigation
    nnoremap <C-j> <C-w><C-j>
    nnoremap <C-k> <C-w><C-k>
    nnoremap <C-l> <C-w><C-l>
    nnoremap <C-h> <C-w><C-h>

    nnoremap <M-j> <C-w>J
    nnoremap <M-k> <C-w>K
    nnoremap <M-l> <C-w>L
    nnoremap <M-h> <C-w>H

    nnoremap J 4j
    nnoremap K 4k
    vnoremap J 4j
    vnoremap K 4k

    """ --- Cscope Configuration ---

        nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
        nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
        nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
        nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
        nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
        nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
        nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
        nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

    """ --- Leader configuration ---

        let mapleader = "\<space>"  " set leader as space

        " -- Evlauate commands

            " [Evaluate Config] Evaluating the vimrc
            nnoremap <leader>ec :source $MYVIMRC<CR>
            
        " -- Open commands
            
            " [Open Config] Opening the init.vim
            nnoremap <leader>oc :vsplit $MYVIMRC<CR>
            
        " -- Folding commands --
        
            nnoremap <leader>zz :set foldmethod=manual<CR>
        
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

        " -- Find commands --

            nnoremap <leader>f :call <SID>Jumper()<CR>

        " -- Search commands --
           
            " [Search File] 
            nnoremap <leader>sf :call <SID>FZFLaunch()<CR>

            " [Search Content in files] 
            nnoremap <leader>sc :call <SID>RipGrepLaunch()<CR>

    """ --- Custom Operators Bindings ---
        
        " -- Surround Operator

            nnoremap <silent> cs :call <SID>ChangeSurroundOperator()<cr>
            nnoremap <silent> gs :<C-u>set operatorfunc=<SID>GoSurroundOperator<CR>g@
            vnoremap <silent> gs :<C-u>call <SID>GoSurroundOperator(visualmode())<CR>

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

        " -- C Text Objects
            
            " C for loop text object

                let g:c_for_pattern = "^\\s*for\\s+(.*).*$"

                " Motion

                    autocmd FileType c nnoremap <buffer> <silent> <M-r> :<c-u>call <SID>NormalMoveCTextObject(g:c_for_pattern, 1, v:count)<cr>
                    autocmd FileType c onoremap <buffer> <silent> <M-r> :call <SID>OperPendCTextObject(g:c_for_pattern, 1, v:count)<cr>
                    autocmd FileType c vnoremap <buffer> <silent> <M-r> :<c-u>call <SID>VisualMoveCTextObject(g:c_for_pattern, 1, v:count)<cr>

                    autocmd FileType c nnoremap <buffer> <silent> <M-R> :<c-u>call <SID>NormalMoveCTextObject(g:c_for_pattern, 0, v:count)<cr>
                    autocmd FileType c onoremap <buffer> <silent> <M-R> :call <SID>OperPendCTextObject(g:c_for_pattern, 0, v:count)<cr>
                    autocmd FileType c vnoremap <buffer> <silent> <M-R> :<c-u>call <SID>VisualMoveCTextObject(g:c_for_pattern, 0, v:count)<cr>

                " Text Object Selection

                    autocmd FileType c onoremap <buffer> <silent> ir :<c-u>call <SID>InnerOuterCTextObject(g:c_for_pattern, v:count, 1)<cr>
                    autocmd FileType c onoremap <buffer> <silent> ar :<c-u>call <SID>InnerOuterCTextObject(g:c_for_pattern, v:count, 0)<cr>

                    autocmd FileType c vnoremap <buffer> <silent> ir :<c-u>call <SID>InnerOuterCTextObject(g:c_for_pattern, v:count, 1)<cr>
                    autocmd FileType c vnoremap <buffer> <silent> ar :<c-u>call <SID>InnerOuterCTextObject(g:c_for_pattern, v:count, 0)<cr>

                    autocmd FileType c onoremap <buffer> <silent> iR :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_for_pattern, v:count, 1)<cr>
                    autocmd FileType c onoremap <buffer> <silent> aR :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_for_pattern, v:count, 0)<cr>

                    autocmd FileType c vnoremap <buffer> <silent> iR :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_for_pattern, v:count, 1)<cr>
                    autocmd FileType c vnoremap <buffer> <silent> aR :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_for_pattern, v:count, 0)<cr>

            " C while loop text object

                let g:c_while_pattern = "^\\s*while\\s+(.*).*$"

                " Motion

                    autocmd FileType c nnoremap <buffer> <silent> <M-e> :<c-u>call <SID>NormalMoveCTextObject(g:c_while_pattern, 1, v:count)<cr>
                    autocmd FileType c onoremap <buffer> <silent> <M-e> :call <SID>OperPendCTextObject(g:c_while_pattern, 1, v:count)<cr>
                    autocmd FileType c vnoremap <buffer> <silent> <M-e> :<c-u>call <SID>VisualMoveCTextObject(g:c_while_pattern, 1, v:count)<cr>

                    autocmd FileType c nnoremap <buffer> <silent> <M-E> :<c-u>call <SID>NormalMoveCTextObject(g:c_while_pattern, 0, v:count)<cr>
                    autocmd FileType c onoremap <buffer> <silent> <M-E> :call <SID>OperPendCTextObject(g:c_while_pattern, 0, v:count)<cr>
                    autocmd FileType c vnoremap <buffer> <silent> <M-E> :<c-u>call <SID>VisualMoveCTextObject(g:c_while_pattern, 0, v:count)<cr>

                " Text Object Selection

                    autocmd FileType c onoremap <buffer> <silent> ie :<c-u>call <SID>InnerOuterCTextObject(g:c_while_pattern, v:count, 1)<cr>
                    autocmd FileType c onoremap <buffer> <silent> ae :<c-u>call <SID>InnerOuterCTextObject(g:c_while_pattern, v:count, 0)<cr>

                    autocmd FileType c vnoremap <buffer> <silent> ie :<c-u>call <SID>InnerOuterCTextObject(g:c_while_pattern, v:count, 1)<cr>
                    autocmd FileType c vnoremap <buffer> <silent> ae :<c-u>call <SID>InnerOuterCTextObject(g:c_while_pattern, v:count, 0)<cr>

                    autocmd FileType c onoremap <buffer> <silent> iE :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_while_pattern, v:count, 1)<cr>
                    autocmd FileType c onoremap <buffer> <silent> aE :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_while_pattern, v:count, 0)<cr>

                    autocmd FileType c vnoremap <buffer> <silent> iE :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_while_pattern, v:count, 1)<cr>
                    autocmd FileType c vnoremap <buffer> <silent> aE :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_while_pattern, v:count, 0)<cr>

            " C if text object

                let g:c_if_pattern = "^\\s*if\\s+(.*).*$"

                " Motion

                    autocmd FileType c nnoremap <buffer> <silent> <M-f> :<c-u>call <SID>NormalMoveCTextObject(g:c_if_pattern, 1, v:count)<cr>
                    autocmd FileType c onoremap <buffer> <silent> <M-f> :call <SID>OperPendCTextObject(g:c_if_pattern, 1, v:count)<cr>
                    autocmd FileType c vnoremap <buffer> <silent> <M-f> :<c-u>call <SID>VisualMoveCTextObject(g:c_if_pattern, 1, v:count)<cr>

                    autocmd FileType c nnoremap <buffer> <silent> <M-F> :<c-u>call <SID>NormalMoveCTextObject(g:c_if_pattern, 0, v:count)<cr>
                    autocmd FileType c onoremap <buffer> <silent> <M-F> :call <SID>OperPendCTextObject(g:c_if_pattern, 0, v:count)<cr>
                    autocmd FileType c vnoremap <buffer> <silent> <M-F> :<c-u>call <SID>VisualMoveCTextObject(g:c_if_pattern, 0, v:count)<cr>

                " Text Object Selection

                    autocmd FileType c onoremap <buffer> <silent> if :<c-u>call <SID>InnerOuterCTextObject(g:c_if_pattern, v:count, 1)<cr>
                    autocmd FileType c onoremap <buffer> <silent> af :<c-u>call <SID>InnerOuterCTextObject(g:c_if_pattern, v:count, 0)<cr>

                    autocmd FileType c vnoremap <buffer> <silent> if :<c-u>call <SID>InnerOuterCTextObject(g:c_if_pattern, v:count, 1)<cr>
                    autocmd FileType c vnoremap <buffer> <silent> af :<c-u>call <SID>InnerOuterCTextObject(g:c_if_pattern, v:count, 0)<cr>

                    autocmd FileType c onoremap <buffer> <silent> iF :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_if_pattern, v:count, 1)<cr>
                    autocmd FileType c onoremap <buffer> <silent> aF :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_if_pattern, v:count, 0)<cr>

                    autocmd FileType c vnoremap <buffer> <silent> iF :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_if_pattern, v:count, 1)<cr>
                    autocmd FileType c vnoremap <buffer> <silent> aF :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_if_pattern, v:count, 0)<cr>

            " C function text object

                let g:c_func_pattern = "^\\s*\\w+\\s+[a-zA-Z0-9_\-]+\\(.*\\).*$"

                " Motion

                    autocmd FileType c nnoremap <buffer> <silent> <M-m> :<c-u>call <SID>NormalMoveCTextObject(g:c_func_pattern, 1, v:count)<cr>
                    autocmd FileType c onoremap <buffer> <silent> <M-m> :call <SID>OperPendCTextObject(g:c_func_pattern, 1, v:count)<cr>
                    autocmd FileType c vnoremap <buffer> <silent> <M-m> :<c-u>call <SID>VisualMoveCTextObject(g:c_func_pattern, 1, v:count)<cr>

                    autocmd FileType c nnoremap <buffer> <silent> <M-M> :<c-u>call <SID>NormalMoveCTextObject(g:c_func_pattern, 0, v:count)<cr>
                    autocmd FileType c onoremap <buffer> <silent> <M-M> :call <SID>OperPendCTextObject(g:c_func_pattern, 0, v:count)<cr>
                    autocmd FileType c vnoremap <buffer> <silent> <M-M> :<c-u>call <SID>VisualMoveCTextObject(g:c_func_pattern, 0, v:count)<cr>

                " Text Object Selection

                    autocmd FileType c onoremap <buffer> <silent> im :<c-u>call <SID>InnerOuterCTextObject(g:c_func_pattern, v:count, 1)<cr>
                    autocmd FileType c onoremap <buffer> <silent> am :<c-u>call <SID>InnerOuterCTextObject(g:c_func_pattern, v:count, 0)<cr>

                    autocmd FileType c vnoremap <buffer> <silent> im :<c-u>call <SID>InnerOuterCTextObject(g:c_func_pattern, v:count, 1)<cr>
                    autocmd FileType c vnoremap <buffer> <silent> am :<c-u>call <SID>InnerOuterCTextObject(g:c_func_pattern, v:count, 0)<cr>

                    autocmd FileType c onoremap <buffer> <silent> iM :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_func_pattern, v:count, 1)<cr>
                    autocmd FileType c onoremap <buffer> <silent> aM :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_func_pattern, v:count, 0)<cr>

                    autocmd FileType c vnoremap <buffer> <silent> iM :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_func_pattern, v:count, 1)<cr>
                    autocmd FileType c vnoremap <buffer> <silent> aM :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_func_pattern, v:count, 0)<cr>


""" ---- Custom Plugins ----

    " --- Terminals Applicaitons ---
        
        " --- Common ---
        
            let g:terminal_buf_id = -1
            let g:terminal_ignore_exit_code = 0
            let g:terminal_content = []
            let g:terminal_on_exit_execute_code = "silent! normal! ".":echo 'nothing to do!'"."\r"

            function! TerminalOnExit(job_id, code, event)
                let g:terminal_content = nvim_buf_get_lines(g:terminal_id, 0, -1, 0)
                
                " close the terminal buffer after exit.
                close

                if g:terminal_ignore_exit_code == 0
                    if a:code == 0
                        " execute the code wanted by caller
                        execute g:terminal_on_exit_execute_code
                    endif
                else
                    execute g:terminal_on_exit_execute_code
                endif
            endfunction

            function! TerminalLaunch(cmd, on_exit_code, launch_type, ignore_exit_code)
                " spliting the window for the terminal
                if a:launch_type == 0
                    split
                elseif a:launch_type == 1
                    vsplit
                elseif a:launch_type == 2
                    tabnew
                endif

                " creating ne buffer for the terminal to go into.
                enew
                " saving the number of the buffer of the terminal
                " for the close operation
                let g:terminal_id = bufnr("%")
                let g:terminal_ignore_exit_code = a:ignore_exit_code

                if len(a:on_exit_code) > 0
                    " setting the code to be run once the terminal exits.
                    let g:terminal_on_exit_execute_code = a:on_exit_code
                endif

                " launching the terminal witht he command
                call termopen(a:cmd, {'on_exit': "TerminalOnExit"})

                " entering insert mode after the terminal is launched.
                normal i
            endfunction

        " --- FZF ---

            function! FZFOnExit()
                execute "silent! normal! ".":e ".g:terminal_content[0]."\r"
            endfunction

            function! s:FZFLaunch()
                call TerminalLaunch("fzf", "silent! normal! :call FZFOnExit()\r", 0, 0)
            endfunction

        " --- Rig Grep ---

            function! RipGrepOnExit()
                let l:newqflist = []
                let l:ripgrep_line = ""

                " Setting the quickfix list with the ripgrep results
                for l:ripgrep_line in g:terminal_content
                    " check if the line is in the correct format
                    if match(l:ripgrep_line, "^.*:\\d\\+:\\d\\+:.*$") < 0
                        continue
                    endif

                    let l:file_path = split(l:ripgrep_line, ':')[0]
                    let l:file_line = split(l:ripgrep_line, ':')[1]
                    let l:file_column = split(l:ripgrep_line, ':')[2]
                    let l:text = split(l:ripgrep_line, ':')[3]

                    " adding new entry to the new quickfix list
                    call add(l:newqflist, {
                                \ 'filename': l:file_path,
                                \ 'lnum': l:file_line,
                                \ 'text': l:text
                                \ })
                endfor

                " setting the new quick fix list with the ripgrep resutls!
                call setqflist(l:newqflist)

                " open quickfix list in case there are results
                if len(l:newqflist) > 0
                    execute "silent! normal! :cw\r"
                endif
            endfunction

            function! s:RipGrepLaunch()
                call inputsave()
                let l:to_search = input("rg --vimgrep ")
                call inputrestore()

                if len(l:to_search) > 0
                    call TerminalLaunch("rg --vimgrep ".l:to_search, "silent! normal! :call RipGrepOnExit()\r", 2, 1)
                endif
            endfunction

    " --- Jumper ---

        function! s:HighlightMatches(matches, start_line)
            " clear everything before highlight new.
            highlight clear
            call clearmatches()

            highlight Jumper_1 ctermfg=black ctermbg=green
            highlight Jumper_2 ctermfg=black ctermbg=blue

            for l:_match in a:matches
                let l:line = a:start_line + l:_match[0]
                let l:col_start = l:_match[1]
                let l:col_end = l:_match[2] + 1

                let l:pattern = "\\%".l:line."l\\%>".l:col_start."c\\%<".l:col_end."c"

                call matchadd('Jumper_1', l:pattern, 1)

                let l:pattern = "\\%".l:line."l\\%".l:col_end."c"
                call matchadd('Jumper_2', l:pattern, 2)
            endfor

            " make the highlights changes to take effect
            redraw
        endfunction

        function! s:IsCandidate(matches, line_number, col_number)
            " if the first run always return true
            if a:matches[0][0] == -1
                return a:col_number
            endif

            for l:_match in a:matches
                if l:_match[0] == a:line_number && l:_match[2] == a:col_number
                    return _match[1]
                endif
            endfor
            return -1
        endfunction

        function! s:ExpandMatches(lines, matches)
            let l:new_matches = []
            let l:duplicates = []
            for l:_match in a:matches
                let l:_match_str = a:lines[l:_match[0]][l:_match[1]:]

                let l:longest_match = 0
                let l:multiple_matches = 0
                for l:__match in a:matches
                    " ignore if the same match
                    if l:__match[0] == l:_match[0] && l:__match[1] == l:_match[1] && l:__match[2] == l:__match[2]
                        continue
                    endif

                    let l:__match_str = a:lines[l:__match[0]][l:__match[1]:]

                    let l:current_match_len = 0

                    let l:loop_len = len(l:_match_str)
                    let l:loop_index = 0
                    while l:loop_index < l:loop_len
                        if l:_match_str[l:loop_index] != l:__match_str[l:loop_index]
                            break
                        endif
                        let l:current_match_len += 1
                        let l:loop_index += 1
                    endwhile

                    if l:current_match_len > l:longest_match
                        let l:longest_match = l:current_match_len
                        let l:multiple_matches = 0
                    elseif l:current_match_len == l:longest_match && l:__match_str[l:loop_index] == l:_match_str[l:loop_index]
                        let l:multiple_matches = 1
                    endif
                endfor

                if l:longest_match == len(l:_match_str) || l:multiple_matches == 1
                    let l:found = 0
                    " add to matches if the first one
                    for l:dup in l:duplicates
                        if l:dup[0] == l:_match[0] && l:dup[1] == l:_match[1]
                            let l:found = 1
                            break
                        endif
                    endfor 

                    if l:found == 0
                        call add(l:new_matches, [l:_match[0], l:_match[1], l:_match[1] + l:longest_match])
                    endif

                    call add(l:duplicates, [l:_match[0], l:_match[1]])
                else
                    " adding the new expanded match
                    call add(l:new_matches, [l:_match[0], l:_match[1], l:_match[1] + l:longest_match])
                endif
            endfor
            return [l:new_matches, l:duplicates]
        endfunction

        function! s:AllMatchesTheSame(lines, matches)
            " getting the first match to compare
            let l:memory = a:lines[a:matches[0][0]][a:matches[0][1]:a:matches[0][2]]

            for l:_match in a:matches
                let l:_match_str = a:lines[l:_match[0]][l:_match[1]:l:_match[2]]
                if l:memory != l:_match_str
                    return 0
                endif
            endfor
            return 1
        endfunction

        function! s:GetEndOfLineMatches(lines, prev_matches)
            let l:results = []

            for l:_match in a:prev_matches
                " the match is pointing to the end of the line
                if len(a:lines[l:_match[0]]) == l:_match[2]
                    call add(l:results, l:_match)
                endif
            endfor

            return l:results
        endfunction

        function! s:SearchLines(lines, char, prev_matches)
            let l:results = []
            let l:line_number = 0

            for l:_line in a:lines
                let l:col_number = 0
                for l:_char in split(_line, '\zs')
                    let l:start_col_of_candidate = <SID>IsCandidate(a:prev_matches, l:line_number, l:col_number)
                    if l:start_col_of_candidate != -1
                        if l:_char == a:char
                            " adding the location of the match
                            call add(l:results, [l:line_number, l:start_col_of_candidate, l:col_number])
                        endif
                    endif
                    let l:col_number += 1
                endfor
                let l:line_number += 1
            endfor
            return l:results
        endfunction

        function! s:Jumper()
            " line number, start column number, end column number
            let l:matches = [[-1,-1,-1]]

            let l:start_line = line('w0')
            let l:end_line = line('w$')

            let l:duplicates = [[line('.') - l:start_line, col('.')]]

            let l:visible_lines = nvim_buf_get_lines(0, l:start_line - 1, l:end_line, 0)

            while 1
                let l:user_char_number = getchar()
                " if user press ESC
                if l:user_char_number == 27
                    if len(l:duplicates) == 0
                        break
                    endif
                    call setpos('.', [0, l:start_line + l:duplicates[0][0], l:duplicates[0][1], 0])
                    break
                " if user press ENTER
                elseif l:user_char_number == 13
                    let l:matches = <SID>GetEndOfLineMatches(l:visible_lines, l:matches)
                " if user press valid character
                else
                    let l:user_char = nr2char(l:user_char_number)
                    let l:matches = <SID>SearchLines(l:visible_lines, l:user_char, l:matches)
                endif

                let l:expand_result = <SID>ExpandMatches(l:visible_lines, l:matches)
                let l:matches = l:expand_result[0]
                let l:duplicates = l:expand_result[1]

                " if found move cursor
                if len(l:matches) == 1
                    call setpos('.', [0, l:start_line + l:matches[0][0], l:matches[0][1] + 1, 0 ])
                    break
                elseif len(l:matches) == 0
                    break
                elseif <SID>AllMatchesTheSame(l:visible_lines, l:matches) == 1
                    " TODO: add to search buffer for use in n and N.
                    " for now move to the first match.
                    call setpos('.', [0, l:start_line + l:matches[0][0], l:matches[0][1] + 1, 0 ])
                    break
                endif

                call <SID>HighlightMatches(l:matches, l:start_line)
            endwhile

            " clearing the highlight we made.
            highlight clear
            call clearmatches()
        endfunction
    
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

            function! s:ChangeSurroundOperator()
                " Save cursor position
                let l:saved_cursor_position = getcurpos()

                " Get the character to change
                let l:before_character = nr2char(getchar())

                let l:left_before_character = <SID>GetSidesSurroundOperator(l:before_character)[0]
                let l:right_before_character = <SID>GetSidesSurroundOperator(l:before_character)[1]
                if l:left_before_character ==# -1
                    return
                endif

                " Check left side
                if search(l:left_before_character, 'bcnWz') ==# 0
                    return 
                endif 

                " Check right side
                if search(l:left_before_character, 'nWz') ==# 0
                    return 
                endif 


                " Get the character to change with
                let l:after_character = nr2char(getchar())

                let l:left_after_character = <SID>GetSidesSurroundOperator(l:after_character)[0]
                let l:right_after_character = <SID>GetSidesSurroundOperator(l:after_character)[1]

                if l:left_after_character ==# -1
                    return
                endif

                " Handle the left side
                if search(l:left_before_character, 'bcW') !=# 0
                    execute "silent! normal! "."r".l:left_after_character
                endif
                
                " Handle the right side
                if search(l:right_before_character, 'W') !=# 0
                    execute "silent! normal! "."r".l:right_after_character
                endif

                call setpos('.', l:saved_cursor_position)
            endfunctio

            function! s:MainSurroundOperator(start_range, end_range)
                let l:start = getpos(a:start_range)
                let l:end = getpos(a:end_range)

                " Set cursor to start of range
                call setpos('.', l:start)

                " Get the character to change
                let l:surround_character = nr2char(getchar())

                let l:left_surround_character = <SID>GetSidesSurroundOperator(l:surround_character)[0]
                let l:right_surround_character = <SID>GetSidesSurroundOperator(l:surround_character)[1]
                if l:left_surround_character ==# -1
                    return
                endif

                execute "silent! normal! "."i".l:left_surround_character

                " Set cursor to end of range
                call setpos('.', l:end)

                execute "silent! normal! "."la".l:right_surround_character
            endfunction

            function! s:GoSurroundOperator(type)
                " Save unnamed register's content
                let l:saved_unnamed_register = @@
                let l:saved_cursor_position = getcurpos()

                if a:type ==# 'v'
                    let l:start_range = "'<"
                    let l:end_range = "'>"

                    call <SID>MainSurroundOperator(l:start_range, l:end_range)
                elseif a:type ==# 'V'
                    let l:start_range = "'<"
                    let l:end_range = "'>"

                    call <SID>MainSurroundOperator(l:start_range, l:end_range)
                elseif a:type ==# "\<c-v>"                          " Visuall Block mode
                    let l:start_range = "'<"
                    let l:end_range = "'>"

                    call <SID>MainSurroundOperator(l:start_range, l:end_range)
                elseif a:type ==# 'line'
                    let l:start_range = "'["
                    let l:end_range = "']"

                    call <SID>MainSurroundOperator(l:start_range, l:end_range)
                elseif a:type ==# 'char'
                    let l:start_range = "'["
                    let l:end_range = "']"

                    call <SID>MainSurroundOperator(l:start_range, l:end_range)
                endif

                " Restore unnamed register's content
                let @@ = l:saved_unnamed_register 

                " Restore cursor position
                call setpos('.', l:saved_cursor_position)
            endfunction

        " -- Comment Operator Implementation

            function! s:GetCommentSyntaxCommentOperator()
                " default will be //
                let l:comment_syntax = "//"
                
                if &filetype ==# 'python'
                    let l:comment_syntax = "#"
                elseif &filetype ==# 'vim'
                    let l:comment_syntax = "\""
                elseif &filetype ==# 'conf'
                    let l:comment_syntax = "#"
                elseif &filetype ==# 'c'
                    let l:comment_syntax = "//"
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

                " Setting the comment after all the whitespaces.
                call setline(a:lnum, substitute(l:line, '^\(\s*\)',  "\\1". l:comment." ", 'g'))
            endfunction

            function! s:UncommentLineCommentOperator(lnum)
                let l:line = getline(a:lnum)
                let l:comment = <SID>GetCommentSyntaxCommentOperator()
                let l:comment_pattern_1 = l:comment."\\s"
                let l:comment_pattern_2 = l:comment."\\w\\+"

                let l:delete_legnth = strlen(l:comment) + 1
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
                        let l:line = l:line[l:delete_legnth:]
                    elseif l:found_index > 0
                        let l:line = l:line[:l:found_index - 1].l:line[l:found_index + l:delete_legnth:]
                    endif
                else
                    let l:found_index = match(l:line, l:comment_pattern_2)

                    if l:found_index ==# 0
                        let l:line = l:line[l:delete_legnth - 1:]
                    elseif l:found_index > 0
                        let l:line = l:line[:l:found_index - 1].l:line[l:found_index + l:delete_legnth  - 1:]
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
                            execute "silent! normal! k"
                            break
                        endif
                    endif
                endwhile

                " if l:is_end_of_file ==# 0
                    " execute "silent! normal! k"
                " endif

                " Keep up until not an empty line
                while match(getline(line(".")), "^\\s*$") > -1
                    execute "silent! normal! k"
                endwhile
                execute "silent! normal! $"
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

                let l:start_indent_level = indent(line("."))

                " Got to previous for decleration
                execute "silent! normal! ".'?\v'.a:python_statement_pattern."\r"

                let l:indent_level = indent(line("."))

                while l:indent_level >= l:start_indent_level
                    execute "silent! normal! n"
                    let l:indent_level = indent(line("."))
                endwhile

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

                execute "silent! normal! $"

                " Return the user's wrapscan settings.
                let &wrapscan=l:saved_wrapscan
            endfunction

            function! s:InnerOuterStatementPyTextObject(python_statement_pattern, count, is_inner)
                " Save the user's wrapscan settings.
                let l:saved_wrapscan = &wrapscan

                let &wrapscan = 0
                execute "silent! normal! l"

                let l:start_indent_level = indent(line("."))

                " Got to previous for decleration
                execute "silent! normal! ".'?\v'.a:python_statement_pattern."\r"

                let l:indent_level = indent(line("."))
                while l:indent_level >= l:start_indent_level
                    execute "silent! normal! n"
                    let l:indent_level = indent(line("."))
                endwhile

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
                    " autocmd FileType python vnoremap <buffer> <silent> aR
		    " :<c-u>call
		    " <SID>InnerOuterStatementPyTextObject(g:python_for_pattern,
		    " v:count, 0)<cr>

        " -- C Text  Objects

            function! s:NormalMoveCTextObject(c_statement_pattern, to_next, count)
                " Save the user's wrapscan settings.
                let l:saved_wrapscan = &wrapscan

                let &wrapscan = 0

                let l:direction = '/'
                if a:to_next ==# 0
                    let l:direction = '?'
                endif

                execute "silent! normal! ".l:direction.'\v'.a:c_statement_pattern."\r"

                " Repeat the search \<count\> times.
                execute "silent! normal! ".repeat("n", a:count - 1)
                
                " Return the user's wrapscan settings.
                let &wrapscan=l:saved_wrapscan
            endfunction

            function! s:VisualMoveCTextObject(c_statement_pattern, to_next, count)
                normal! gv
                call <SID>NormalMoveCTextObject(a:c_statement_pattern, a:to_next, a:count)
            endfunction

            function! s:OperPendCTextObject(c_statement_pattern, to_next, count)
                normal! v
                call NormalMoveCTextObject(a:c_statement_pattern, a:to_next, a:count)
                normal! k$
            endfunction

            function! s:InnerOuterCTextObject(c_statement_pattern, count, is_inner)
                " Save the user's wrapscan settings.
                let l:saved_wrapscan = &wrapscan

                let &wrapscan = 0

                execute "silent! normal! $"

                " Got to previous for decleration
                execute "silent! normal! ".'?\v'.a:c_statement_pattern."\r"

                let &whichwrap = "lh"
                if a:is_inner
                    execute "silent! normal! ".'/\v'.'\{'."\r"
                    execute "silent! normal! lv"
                    execute "silent! normal! h%h"
                else
                    execute "silent! normal! ^v"
                    execute "silent! normal! ".'/\v'.'\{'."\r"
                    execute "silent! normal! %"
                endif
                let &whichwrap = ""

                " Return the user's wrapscan settings.
                let &wrapscan=l:saved_wrapscan
            endfunction

            function! s:InnerOuterStatementCTextObject(c_statement_pattern, count, is_inner)
                " Save the user's wrapscan settings.
                let l:saved_wrapscan = &wrapscan

                let &wrapscan = 0

                execute "silent! normal! $"

                " Got to previous for decleration
                execute "silent! normal! ".'?\v'.a:c_statement_pattern."\r"

                let &whichwrap = "lh"
                if a:is_inner
                    " get current line
                    let l:line = getline('.')

                    if match(l:line, "^.*().*$") >= 0
                        " Add space between the parenthesis
                        execute "silent! normal! f(a \<esc>0"
                    endif 

                    execute "silent! normal! f(lvh%h"
                else
                    execute "silent! normal! ^vf(%"
                endif
                let &whichwrap = ""

                " Return the user's wrapscan settings.
                let &wrapscan=l:saved_wrapscan
            endfunction
