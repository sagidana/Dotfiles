""" ---- Plug configuration ----

    call plug#begin(stdpath('data') . '/plugged')

    Plug 'neovim/nvim-lspconfig'

    call plug#end()


""" ---- General configuration ----

    set nocompatible            " Disable compatibility to old-time vi
    set showmatch               " Show matching brackets.
    set noswapfile              " disable swap files permanently
    set hlsearch                " highlight search results
    set incsearch               " highlight saerch results while searching.
    set inccommand=nosplit      " highlight search results while sustitude.
    set tabstop=4               " number of columns occupied by a tab character
    set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
    set expandtab               " converts tabs to white space
    set shiftwidth=4            " width for autoindents
    set autoindent              " indent a new line the same amount as the line just typed
    set number                  " add line numbers
    set relativenumber          " setting relative numbers
    set foldmethod=indent       " setting folding to indentations
    set foldlevel=20            " unfold all folds by default
    set foldignore=             " this is to ignore the # when folding!! so goood!!!
    set splitright              " split to the right.
    set splitbelow              " the default split direction will be at the bottom
    set mouse=a                 " enable mouse support (selection, resize).
    set tags=tags               " enable ctags
    set synmaxcol=0             " disable limit on syntax highlight col max.
    set clipboard+=unnamedplus  " copy to system clipboard automagically
    set nowrap                  " this is a nice default so the files would
                                "look sane, I can always type ':set wrap<cr>' manually when needed
    set signcolumn=yes          " leave sign column always on to prevent 'jumps'
    set undofile                     " enable undo file history save
    set undodir=~/.config/nvim/undo  " put the histroy in a dedicated folder

    " https://askubuntu.com/questions/125526/vim-in-tmux-display-wrong-colors
    " fixes colors between .bashrc -> .tmux.conf -> .vimrc
    if exists('+termguicolors') && ($TERM == "tmux-256color")
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        set termguicolors
    endif

    " -- Status Line --
    set statusline=
    set statusline+=\ %n        " buffer number
    set statusline+=\ %M        " is the file has being modified?
    set statusline+=\ %y        " the file type
    set statusline+=\ %r        " is read-only?
    set statusline+=\ %f        " relative file path
    set statusline+=%=          " all settings after this are alligned right
    set statusline+=\ %l:%c     " show line:column
    set statusline+=\ [%p%%]    " the precentage we in the file

    " set jumpoptions+=stack	" set the CTRL-o and CTRL-i behave reasonably.. :0

    let g:markdown_folding=1    " enable markdown folding - Finally!
    " Fix syntax highlighting bugs for markdown:
    " create the file: "~/.config/nvim/after/syntax/markdown.vim"
    " put in the file: "syntax sync fromstart"
    " I can't put this command in the init.vim because it happens too soon. we need this
    " command to run after the syntax rules for markdown are loaded, otherwise the sync will
    " be cleared by the rules loaded. The way to do that is using the after directory of vim
    " and we do that only for markdown (markdown.vim).

    " whitespace characters
    " do 'set list/nolist' to show/hide whitespace characters
    " set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
    set listchars=tab:>·,trail:~
    set list

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

    " only for c use syntax fold method
    autocmd FileType c setlocal foldmethod=syntax
    autocmd FileType cpp setlocal foldmethod=syntax

    " highlight yanked text, lets see if I can start yanking without visual-mode...
    au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=200, on_visual=true}

    " alias vim='nvim -c "let g:tty='\''$(tty)'\''"'
    " function Osc52Yank()
        " let buffer=system('base64 | tr -d "\n"', @0)
        " let buffer="\e]52;c;".buffer."\e\\"
        " call writefile([buffer], g:tty, 'b')
    " endfunction

    " augroup Yank
        " autocmd!
        " autocmd TextYankPost * if v:event.operator ==# 'y' | call Osc52Yank() | endif
    " augroup END

    " unsetting the quickfix window attributes winfixheight and winfixwidth so
    " CTRL-W= will resize the quickfix size
    augroup QuickFix
        autocmd!
        autocmd FileType qf set nowinfixheight | set nowinfixwidth
    augroup END

    " When closing a tab, return to the previously focused tab.
    let g:tablist = [1, 1]
    autocmd TabLeave * let g:tablist[0] = g:tablist[1]
    autocmd TabLeave * let g:tablist[1] = tabpagenr()
    autocmd TabClosed * exe "normal " . g:tablist[0] . "gt"


""" ---- Hex editing ----

    " If one has a particular extension that one uses for binary files (such as exe,
    " bin, etc), you may find it helpful to automate the process with the following
    " bit of autocmds for your <.vimrc>.  Change that "*.bin" to whatever
    " comma-separated list of extension(s) you find yourself wanting to edit:

    " vim -b : edit binary using xxd-format!
    augroup Binary
        au!
        au BufReadPre  *.bin let &bin=1
        au BufReadPost *.bin if &bin | %!xxd
        au BufReadPost *.bin set ft=xxd | endif
        au BufWritePre *.bin if &bin | %!xxd -r
        au BufWritePre *.bin endif
        au BufWritePost *.bin if &bin | %!xxd
        au BufWritePost *.bin set nomod | endif
    augroup END


""" ---- Language Server Protocol configuration ----

    " " Enable python languge server
    " " lua require'nvim_lsp'.jedi_language_server.setup{}
    " lua require'nvim_lsp'.pyls.setup{}
    " autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc

    " " Enable vimscript languge server
    " lua require'nvim_lsp'.vimls.setup{}

    " " Enable c language server
    " " lua require'nvim_lsp'.clangd.setup{}
    " " lua require'nvim_lsp'.ccls.setup{}


""" ---- Colorscheme! ----

    " somehow the only shceme that actualy worked for me in all
    " use cases is the default one... WTF?
    " colorscheme default
    " colorscheme monokai
    colorscheme habamax


""" ---- Bindings ----

    " Disable search highlights until next search at <esc> press.
    nnoremap <esc> :nohlsearch<CR>:call <SID>EnterNormalMode()<CR><esc>

    " Bind tab to fold toggle.
    nnoremap <tab> za

    " Bind <C-i> to <M-o>
    nnoremap <M-o> <C-i>

    " My own history of the cursor implementation
    nnoremap <C-n> :call <SID>RecallNext()<CR>
    nnoremap <C-p> :call <SID>RecallPrev()<CR>

    nnoremap <silent> <C-u> <C-u>:call <SID>RecallPush()<CR>
    nnoremap <silent> <C-d> <C-d>:call <SID>RecallPush()<CR>
    nnoremap <silent> j j:call <SID>RecallPush()<CR>
    nnoremap <silent> k k:call <SID>RecallPush()<CR>

    " Change indentation and keep visualized!
    vnoremap > >gv
    vnoremap < <gv

    " *** in visual mode only ***
    " We re-yank the text we just pasted and go to the end of the pasted text.
    " Reason: we want to be able to redo the replace operation we just did.
    xnoremap <expr> p 'pgvy`>'

    " Search for visually selected text
    vnoremap / y/\V<C-R>=escape(@",'/\')<CR><CR>

    """ --- Language Server Bindings ---

        " nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
        " nnoremap <silent> gh    <cmd>lua vim.lsp.buf.hover()<CR>
        " nnoremap <silent> gx    <cmd>lua vim.lsp.buf.references()<CR>

    """ --- Scope Bindings ---

        nnoremap <C-\>c :call <SID>ScopeXRefs()<CR>
        nnoremap <C-\>s :call <SID>ScopeXSyms()<CR>

    """ --- Leader configuration ---

        let mapleader = "\<space>"  " set leader as space

        " -- AiChat
            vnoremap <silent> <leader>a :<C-u>call <SID>AiChatLaunch()<CR>

        " -- Trailing Whitespace

            nnoremap <silent> <leader>t :call <SID>ShowTrailingWhitespace()<CR>

        " -- Update commands

            " [Update JumpList]
            nnoremap <leader>uj :call <SID>JumpListLoad()<CR>

        " -- Evlauate commands

            " [Evaluate Config] Evaluating the vimrc
            nnoremap <leader>ec :source $MYVIMRC<CR>

        " -- Open commands

            " [Open Config] Opening the init.vim
            nnoremap <leader>oc :vsplit $MYVIMRC<CR>

        " -- Blame commands --

            vnoremap <leader>b :call <SID>BlameLaunch()<CR>

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

        " -- Mark commands --

            nnoremap <leader>mm :call <SID>MarkerMark()<CR>

            nnoremap <leader>mc :call <SID>MarkerClear()<CR>

        " -- Vimable commands --

            nnoremap <leader>vv :call <SID>VimableChooseVimable()<CR>

            nnoremap <silent> <leader>ve :<C-u>set operatorfunc=<SID>VimableExecuteEchoOperator<CR>g@
            vnoremap <silent> <leader>ve :<C-u>call <SID>VimableExecuteEchoOperator(visualmode())<CR>

            nnoremap <silent> <leader>vE :<C-u>set operatorfunc=<SID>VimableExecuteBufferOperator<CR>g@
            vnoremap <silent> <leader>vE :<C-u>call <SID>VimableExecuteBufferOperator(visualmode())<CR>

        " -- Find commands --

            nnoremap <leader>f :call <SID>Jumper()<CR>

        " -- Knowit commands --

            nnoremap <leader>kl :call <SID>KnowitLinkLaunch()<CR>
            nnoremap <leader>kb :call <SID>KnowitBrowseLaunch()<CR>

        " -- Search commands --

            " [Search File]
            nnoremap <leader>sf :call <SID>FZFLaunch()<CR>

            " [Search Content in files]
            nnoremap <leader>sc :call <SID>RipGrepLaunch(0)<CR>
            vnoremap <leader>sc :call <SID>RipGrepLaunch(1)<CR>

            " [Search Live Content in files] 
            nnoremap <leader>sl :call <SID>LiveRipGrepLaunch(0)<CR>
            vnoremap <leader>sl :call <SID>LiveRipGrepLaunch(1)<CR>

    """ --- Custom Operators Bindings ---

        " -- Surround Operator

            nnoremap <silent> cs :call <SID>ChangeSurroundOperator()<cr>
            nnoremap <silent> gs :<C-u>set operatorfunc=<SID>GoSurroundOperator<CR>g@
            vnoremap <silent> gs :<C-u>call <SID>GoSurroundOperator(visualmode())<CR>

        " -- Doc Operator

            nnoremap <silent> <leader>d :<C-u>set operatorfunc=<SID>DocOperator<CR>g@
            vnoremap <silent> <leader>d :<C-u>call <SID>DocOperator(visualmode())<CR>

        " -- Comment Operator

            nnoremap <silent> gc :<C-u>set operatorfunc=<SID>CommentOperator<CR>g@
            vnoremap <silent> gc :<C-u>call <SID>CommentOperator(visualmode())<CR>

        " -- Printer Operator

            nnoremap <silent> gp :<C-u>set operatorfunc=<SID>PrinterOperator<CR>g@
            vnoremap <silent> gp :<C-u>call <SID>PrinterOperator(visualmode())<CR>

    """ --- Custom Text Objects Bindings ---

        " -- Indent Text Object

            " Text Object Selection

                onoremap <silent> ii :<c-u>call <SID>InnerOuterIndentTextObject(v:count)<cr>
                onoremap <silent> ai :<c-u>call <SID>InnerOuterIndentTextObject(v:count)<cr>

                vnoremap <silent> ii :<c-u>call <SID>InnerOuterIndentTextObject(v:count)<cr>
                vnoremap <silent> ai :<c-u>call <SID>InnerOuterIndentTextObject(v:count)<cr>


""" ---- Custom Plugins ----

    " --- Misc ---

        function! s:ShowTrailingWhitespace()
            highlight UselessWhitespace ctermbg=red guibg=red
            match UselessWhitespace /\s\+$/
        endfunction

        function! s:EnterNormalMode()
            call clearmatches()
        endfunction

    " --- Http Utils ---

        function! s:HttpDoubleEscapeString(string)
            let l:string = ""
            let l:index = 0
            let l:len = len(a:string)
            while l:index < l:len
                if a:string[l:index] == '"'
                    " echon a:string[l:index]
                    let l:string = l:string . "\\" . "\""
                else

                    let l:string = l:string . a:string[l:index]
                endif

                let l:index += 1
            endwhile
            return l:string
        endfunction

        function! HttpPost(url, data)
            let l:curl_command = ""
            let l:result = ""

            let l:data = <SID>HttpDoubleEscapeString(a:data)
            let l:curl_command = "curl -s -X POST -H 'Content-Type: text/html' " . a:url . " -d \"" . l:data . "\""
            let l:result = system(l:curl_command)
            return l:result
        endfunction

        function! HttpGet(url, parameters)
            let l:curl_command = ""
            let l:parameters = ""
            let l:parameter = ""
            let l:result = ""

            for l:parameter in items(a:parameters)
                let l:parameters = l:parameters . "&" . l:parameter[0] . "=" . l:parameter[1]
            endfor

            let l:curl_command = "curl -s -X GET " . a:url . "?" .l:parameters

            let l:result = system(l:curl_command)
            " echomsg l:result
            return l:result
        endfunction

    " --- Terminals Applicaitons ---

        " --- Common ---

            let g:terminal_buf_id = -1
            let g:terminal_ignore_exit_code = 0
            let g:terminal_dont_close = 0
            let g:terminal_content = []
            let g:terminal_on_exit_execute_code = "silent! normal! ".":echo 'nothing to do!'"."\r"

            function! TerminalOnExit(job_id, code, event)
                let g:terminal_content = nvim_buf_get_lines(g:terminal_id, 0, -1, 0)

                " close the terminal buffer after exit.
                if g:terminal_dont_close == 0
                    close
                endif

                if g:terminal_ignore_exit_code == 0
                    if a:code == 0
                        " execute the code wanted by caller
                        execute g:terminal_on_exit_execute_code
                    endif
                else
                    execute g:terminal_on_exit_execute_code
                endif
            endfunction

            function! TerminalLaunch(cmd, on_exit_code, launch_type, ignore_exit_code, dont_close)
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
                let g:terminal_dont_close = a:dont_close

                if len(a:on_exit_code) > 0
                    " setting the code to be run once the terminal exits.
                    let g:terminal_on_exit_execute_code = a:on_exit_code
                endif

                " launching the terminal with the command
                call termopen(a:cmd, {'on_exit': "TerminalOnExit"})

                if a:dont_close == 0
                    " entering insert mode after the terminal is launched.
                    normal i
                else
                    normal G
                endif

            endfunction

        " --- Aichat ---

            function! s:AiChatLaunch()
                let l:current_line = line("'<")
                let l:line_end = line("'>")

                let l:lines = []
                while l:current_line <= l:line_end
                    let l:line = getline(l:current_line)
                    call add(l:lines, l:line)
                    let l:current_line = l:current_line + 1
                endwhile

                call writefile(l:lines, "/tmp/.tmp.lines")

                let l:system_prompt = ""
                let l:prompt = input("prompt> ")
                let l:command = "aichat -f /tmp/.tmp.lines --prompt "."\"".l:prompt."\""

                " echom l:command
                call TerminalLaunch(l:command, "", 2, 1, 1)
            endfunction

        " --- FZF ---

            function! FZFOnExit()
                execute "silent! normal! ".":e ".g:terminal_content[0]."\r"
            endfunction

            function! s:FZFLaunch()
                call TerminalLaunch("fzf", "silent! normal! :call FZFOnExit()\r", 0, 0, 0)
            endfunction

        " --- Knowit ---

            function! KnowitLinkOnExit()
                execute "silent! normal! "."i".g:terminal_content[0]
            endfunction

            function! s:KnowitLinkLaunch()
                call TerminalLaunch("python /home/s/github/knowit/knowit.py -a link", "silent! normal! :call KnowitLinkOnExit()\r", 0, 0, 0)
            endfunction

            function! KnowitBrowseOnExit()
                execute "silent! normal! ".":e ".g:terminal_content[0]."\r"
            endfunction

            function! s:KnowitBrowseLaunch()
                call TerminalLaunch("python /home/s/github/knowit/knowit.py -a link", "silent! normal! :call KnowitBrowseOnExit()\r", 2, 0, 0)
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
                call setloclist(0, l:newqflist)

                " open quickfix list in case there are results
                if len(l:newqflist) > 0
                    execute "silent! normal! :lopen\r"
                endif
            endfunction

            function! s:RipGrepLaunch(input_type)
                if a:input_type == 1 " get input from visual selected
                    " getting the current visually seleceted text
                    " (assume to be only one line)
                    let l:to_search = "\"".getline("'<")[getpos("'<")[2]-1:getpos("'>")[2]-1]."\""
                else
                    call inputsave()
                    let l:to_search = input("rg --vimgrep ")
                    call inputrestore()
                endif

                if len(l:to_search) > 0
                    let l:args = "--max-columns 200 -g '!/resources' -g '!/tags' --vimgrep "
                    call TerminalLaunch("rg ".l:args.l:to_search, "silent! normal! :call RipGrepOnExit()\r", 2, 1, 0)
                endif
            endfunction

        " --- Live Rig Grep ---

            function! LiveRipGrepOnExit()
                let l:ripgrep_line = g:terminal_content[0]
                if match(l:ripgrep_line, "^.*:\\d\\+:\\d\\+:.*$") < 0
                    return
                endif
                let l:file_path = split(l:ripgrep_line, ':')[0]
                let l:file_line = split(l:ripgrep_line, ':')[1]
                let l:file_column = split(l:ripgrep_line, ':')[2]

                execute "silent! normal! :e ".l:file_path."\r"
                execute "silent! normal! :".l:file_line."\r"
            endfunction

            function! s:LiveRipGrepLaunch(input_type)
                if a:input_type == 1 " get input from visual selected
                    " getting the current visually seleceted text
                    " (assume to be only one line)
                    let l:to_search = "\"".getline("'<")[getpos("'<")[2]-1:getpos("'>")[2]-1]."\""
                else
                    let l:to_search = "\"\""
                endif

                let l:rg_command_prefix = "rg --max-columns 200 -g \'!/resources\' -g \'!/tags\' --vimgrep "
                let l:rg_command_suffix = "."
                let l:command = "FZF_DEFAULT_OPTS=\""
                let l:command = l:command."--ansi "
                let l:command = l:command."--delimiter : "
                let l:command = l:command."--disabled "
                let l:command = l:command."--query '".l:to_search."' "
                let l:command = l:command."--bind 'change:reload:".l:rg_command_prefix." \'{q}\' ".l:rg_command_suffix." || true' "
                let l:command = l:command."--bind 'ctrl-k:preview-up' "
                let l:command = l:command."--bind 'ctrl-j:preview-down' "
                let l:command = l:command."--bind 'ctrl-u:preview-half-page-up' "
                let l:command = l:command."--bind 'ctrl-d:preview-half-page-down' "
                let l:command = l:command."--preview-window 'up,70%,+{2}-/2' "
                let l:command = l:command."--preview 'bat --style=auto --color=always -H {2} {1}'\" "
                let l:command = l:command."FZF_DEFAULT_COMMAND=\""
                let l:command = l:command.l:rg_command_prefix." '".l:to_search."' ".l:rg_command_suffix."\""
                let l:command = l:command." fzf"

                call TerminalLaunch(l:command, "normal! :call LiveRipGrepOnExit()\r", 2, 1, 0)
            endfunction

        " --- Blame ---

            function! s:BlameLaunch()
                " let l:linux_git_repo = "/home/s/Github/linux"
                let l:linux_git_repo = "."

                " getting the currently selected lines
                let l:line_start = line("'<")
                let l:line_stop = line("'>")

                " giving me the current file
                let l:file_path = expand("%")

                " the git blame command to execute
                let l:git_command = "git log -L".l:line_start.",".l:line_stop.":".l:file_path

                " this command let me run any command from the linux git repo
                " directory.
                let l:complete_command= "pushd ".l:linux_git_repo." && ".l:git_command." && popd"

                call TerminalLaunch(l:complete_command, "", 2, 1, 1)
            endfunction

        " --- JumpList ---

            function! JumpListOnExit()
                let l:newqflist = []
                let l:jumplist_line = ""

                " Setting the quickfix list with the ripgrep results
                for l:jumplist_line in g:terminal_content
                    " check if the line is in the correct format
                    if match(l:jumplist_line, "^.*:\\d\\+:.*$") < 0
                        continue
                    endif

                    " echomsg l:jumplist_line
                    let l:file_path = split(l:jumplist_line, ':')[0]
                    let l:file_line = split(l:jumplist_line, ':')[1]
                    let l:text = split(l:jumplist_line, ':')[2]

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

            function! s:JumpListLoad()
                call inputsave()
                let l:file_path = input("jumplist file_path:")
                call inputrestore()
                " this command let me run any command from the linux git repo
                " directory.
                let l:command = "cat ".l:file_path
                echomsg l:command

                " call TerminalLaunch(l:command, "silent! normal! :call JumpListOnExit()\r", 2, 1, 0)
                call TerminalLaunch(l:command, "normal! :call JumpListOnExit()\r", 2, 1, 0)
            endfunction

        " --- Scope ---

            function! ScopeXRefsOnExit()
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
                call setloclist(0, l:newqflist)

                " open quickfix list in case there are results
                if len(l:newqflist) > 0
                    execute "silent! normal! :lopen\r"
                endif
            endfunction

            function! s:ScopeXSyms()
                let l:cword = expand("<cword>")
                let l:excluded = "-g '!/resources' -g '!/tags' -g '!/*.out$'"
                let l:args = "--vimgrep --max-columns 200 ".l:excluded
                let l:command = "rg ".l:args." '\\W".l:cword."\\W.*'"

                call TerminalLaunch(l:command, "silent! normal! :call ScopeXRefsOnExit()\r", 2, 1, 0)
            endfunction

            function! s:ScopeXRefs()
                let l:cword = expand("<cword>")
                let l:excluded = "-g '!/resources' -g '!/tags' -g '!/*.out$'"
                let l:args = "--vimgrep --max-columns 200 ".l:excluded
                let l:command = "rg ".l:args." '\\W".l:cword."\\(.*'"

                call TerminalLaunch(l:command, "silent! normal! :call ScopeXRefsOnExit()\r", 2, 1, 0)
            endfunction

    " --- Recall ---

        " define the variables on windows creation
        autocmd WinNew * let w:recall_cursor_locations = []
        autocmd WinNew * let w:recall_index = -1
        let w:recall_cursor_locations = []
        let w:recall_index = -1

        function! s:RecallPush()
            let w:recall_cursor_locations = w:recall_cursor_locations[:w:recall_index]
            call add(w:recall_cursor_locations, getpos("."))
            let w:recall_index = w:recall_index + 1

            if w:recall_index > 99
                let w:recall_cursor_locations = w:recall_cursor_locations[-100:]
                let w:recall_index = 99
            endif
        endfunction

        function! s:RecallPrev()
            if w:recall_index == -1
                return
            endif

            let l:pos = get(w:recall_cursor_locations, w:recall_index)
            call cursor(l:pos[1], l:pos[2])
            let w:recall_index = w:recall_index - 1
        endfunction

        function! s:RecallNext()
            if w:recall_index == len(w:recall_cursor_locations) - 1
                return
            endif
            let w:recall_index = w:recall_index + 1
            let l:pos = get(w:recall_cursor_locations, w:recall_index)
            call cursor(l:pos[1], l:pos[2])
        endfunction

    " --- Vimable ---

        function! s:VimableGetVimables()
            let vimables = {}
            let files = glob("/tmp/vimable_*", v:true, v:true)
            for file in files
                let url = readfile(file)[0]

                " Extract he name of the vimable
                let name = matchlist(file, '/tmp/vimable_\(.*\)')[1]
                let vimables[name] = url
            endfor
            return vimables
        endfunction

        function! s:VimableChooseVimable()
            let vimables = <SID>VimableGetVimables()

            let choices = ""
            let index = 1
            let mapping = {}
            for vimable in items(vimables)
                let mapping[index] = vimable[0]
                let choices = choices . printf("&%d %s\n", index, vimable[0])
                let index +=1
            endfor
            let choices = choices[:-2]

            let choice = confirm("Enter the number of the vimable:", choices)

            " Initialize the vimable to the local buffer
            let b:vimable =   {
                            \   "name" :mapping[choice],
                            \   "url" : vimables[mapping[choice]]
                            \ }

            " Hook vim bindings for vimable functionality:
            " NOTE: Make sure all the changes apply only in the local buffer scope!
            setlocal completefunc=VimableCompletion " CTRL-x + CTRL-u to launch
            setlocal filetype=python
        endfunction

        function! s:VimableExecute(code)
            if !exists('b:vimable')
                echo "Vimable not initialized!"
                return
            endif

            let name = b:vimable['name']
            let url = b:vimable['url']

            let execute_url = url . "execute"
            let response = HttpPost(execute_url, a:code)

            return response
        endfunction

        function! s:VimableGetCompletion(base)
            if !exists('b:vimable')
                echo "Vimable not initialized!"
                return []
            endif

            let name = b:vimable['name']
            let url = b:vimable['url']

            let completion_url = url . "completion"

            let matches = HttpPost(completion_url, a:base)

            let matches = split(matches, ",")

            echom a:base

            return matches
        endfunction

        function! VimableCompletion(findstart, base)
            if a:findstart
                " locate the start of the word.
                let line = getline('.')
                let start = col('.') - 1
                while start > 0 && line[start - 1] =~ '\a'
                    let start -= 1
                endwhile
                return start
            else
                " In vimable case always return from the
                " start of the line, and let the app itself decides whats best.
                " locate the start of the word
                let line = getline('.')
                let start = col('.') - 1
                let correct_base = line[:start-1]
                return <SID>VimableGetCompletion(correct_base) " Should contain line[:curr_col]
            endif
        endfunction

        function! s:MainVimableExecuteOperator(start_range, end_range)
                let l:to_execute = ""

                if line(a:start_range) != line(a:end_range)
                    let l:start_line = line(a:start_range)
                    let l:start_col = col(a:start_range)
                    let l:end_line = line(a:end_range)
                    let l:end_col = col(a:end_range)

                    let l:to_execute = getline(l:start_line)
                    let l:to_execute = l:to_execute[l:start_col - 1:] . "\n"

                    let l:start_line += 1
                    while l:start_line < l:end_line
                        let l:to_execute = l:to_execute . getline(l:start_line) . "\n"
                        let l:start_line += 1
                    endwhile

                    let l:to_execute = l:to_execute . getline(l:end_line)[:l:end_col-1] . "\n"
                else
                    let l:to_execute = getline(line(a:start_range))
                    let l:to_execute = l:to_execute[col(a:start_range) - 1:col(a:end_range) - 1]
                endif

                let l:response = <SID>VimableExecute(l:to_execute)
                return l:response
        endfunction

        function! s:VimableExecuteOperator(type)
            " Save unnamed register's content
            let l:saved_unnamed_register = @@
            let l:saved_cursor_position = getcurpos()
            let l:response = ""

            if a:type ==# 'v'
                let l:start_range = "'<"
                let l:end_range = "'>"

                let l:response = <SID>MainVimableExecuteOperator(l:start_range, l:end_range)
            elseif a:type ==# 'V'
                let l:start_range = "'<"
                let l:end_range = "'>"

                let l:response = <SID>MainVimableExecuteOperator(l:start_range, l:end_range)
            elseif a:type ==# "\<c-v>"                          " Visuall Block mode
                let l:start_range = "'<"
                let l:end_range = "'>"

                let l:response = <SID>MainVimableExecuteOperator(l:start_range, l:end_range)
            elseif a:type ==# 'line'
                let l:start_range = "'["
                let l:end_range = "']"

                let l:response = <SID>MainVimableExecuteOperator(l:start_range, l:end_range)
            elseif a:type ==# 'char'
                let l:start_range = "'["
                let l:end_range = "']"

                let l:response = <SID>MainVimableExecuteOperator(l:start_range, l:end_range)
            endif

            " Restore unnamed register's content
            let @@ = l:saved_unnamed_register

            " Restore cursor position
            call setpos('.', l:saved_cursor_position)
            return l:response
        endfunction

        function! s:VimableExecuteEchoOperator(type)
            let l:response = <SID>VimableExecuteOperator(a:type)
            echon l:response
        endfunction

        function! s:VimableExecuteBufferOperator(type)
            let l:response = <SID>VimableExecuteOperator(a:type)
            execute ":new"
            call nvim_paste(l:response,v:true, -1)
            " call append(0,l:response)
        endfunction

    " --- Marker ---

        function! s:MarkerClear()
            highlight clear
            call clearmatches()
            " make the highlights changes to take effect
            redraw
        endfunction

        function! s:MarkerMark()
            highlight clear
            call clearmatches()
            highlight Marker_1 ctermfg=magenta
            for d in getqflist()
                let l:lnum = d.lnum
                if d.bufnr == bufnr('%')
                    let l:pattern = "\\%".l:lnum."l"
                    call matchadd('Marker_1', l:pattern, 1)
                endif
            endfor
            " make the highlights changes to take effect
            redraw
        endfunction

    " --- Jumper ---

        function! s:GetLineByNumber(lines, line_number)
            for l:line in a:lines
                if l:line[0] == a:line_number
                    return l:line
                endif
            endfor
            return [-1]
        endfunction

        function! s:HighlightMatches(matches)
            " clear everything before highlight new.
            highlight clear
            call clearmatches()

            highlight Jumper_1 ctermfg=black ctermbg=green
            highlight Jumper_2 ctermfg=black ctermbg=blue

            for l:_match in a:matches
                let l:line = l:_match[0]
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
                let l:_match_str = <SID>GetLineByNumber(a:lines, l:_match[0])[1][l:_match[1]:]

                let l:longest_match = 0
                let l:multiple_matches = 0
                for l:__match in a:matches
                    " ignore if the same match
                    if l:__match[0] == l:_match[0] && l:__match[1] == l:_match[1] && l:__match[2] == l:__match[2]
                        continue
                    endif

                    let l:__match_str = <SID>GetLineByNumber(a:lines, l:__match[0])[1][l:__match[1]:]

                    let l:current_match_len = 0

                    let l:loop_len = len(l:_match_str)
                    while l:current_match_len < l:loop_len
                        if l:_match_str[l:current_match_len] != l:__match_str[l:current_match_len]
                            break
                        endif
                        let l:current_match_len += 1
                    endwhile

                    " check if we got to the end of the line.
                    " if we did we have duplicates
                    if l:current_match_len == len(l:_match_str)
                        let l:multiple_matches = 1
                        let l:longest_match = l:current_match_len
                    elseif l:current_match_len > l:longest_match
                        let l:longest_match = l:current_match_len
                        let l:multiple_matches = 0
                    elseif l:current_match_len == l:longest_match && l:__match_str[l:current_match_len] == l:_match_str[l:current_match_len]
                        let l:multiple_matches = 1
                    endif
                endfor

                " adding the new expanded match
                call add(l:new_matches, [l:_match[0], l:_match[1], l:_match[1] + l:longest_match])

                " if there are multiple matches add it to the duplicates so we
                " can uniquely identify them later.
                if l:multiple_matches == 1
                    call add(l:duplicates, [l:_match[0], l:_match[1], l:_match[1] + l:longest_match])
                endif

                " if l:longest_match == len(l:_match_str) || l:multiple_matches == 1
                    " let l:found_in_duplicates = 0
                    " " add to matches if the first one
                    " for l:dup in l:duplicates
                        " if l:dup[0] == l:_match[0] && l:dup[1] == l:_match[1]
                            " let l:found_in_duplicates = 1
                            " break
                        " endif
                    " endfor

                    " " add only the first to the matches.
                    " if l:found_in_duplicates == 0
                        " call add(l:new_matches, [l:_match[0], l:_match[1], l:_match[1] + l:longest_match])
                    " endif

                    " call add(l:duplicates, [l:_match[0], l:_match[1]])
                " else
                    " adding the new expanded match
                    " call add(l:new_matches, [l:_match[0], l:_match[1], l:_match[1] + l:longest_match])
                " endif
            endfor
            return [l:new_matches, l:duplicates]
        endfunction

        function! s:AllMatchesTheSame(lines, matches)
            " getting the first match to compare
            let l:line = <SID>GetLineByNumber(a:lines, a:matches[0][0])
            let l:memory = l:line[1][a:matches[0][1]:a:matches[0][2]]

            for l:_match in a:matches
                let l:curr_line = <SID>GetLineByNumber(a:lines, l:_match[0])
                if l:curr_line[0] == -1
                    continue
                endif
                let l:_match_str = l:curr_line[1][l:_match[1]:l:_match[2]]
                if l:memory != l:_match_str
                    return 0
                endif
            endfor
            return 1
        endfunction

        function! s:GetEndOfLineMatches(lines, prev_matches)
            let l:results = []

            for l:_match in a:prev_matches
                let l:line = <SID>GetLineByNumber(a:lines, l:_match[0])

                " the match is pointing to the end of the line
                if len(l:line[1]) == l:_match[2]
                    call add(l:results, l:_match)
                endif
            endfor

            return l:results
        endfunction

        function! s:SearchLines(lines, char, prev_matches)
            let l:results = []

            for l:_line in a:lines
                let l:col_number = 0
                for l:_char in split(l:_line[1], '\zs')
                    let l:start_col_of_candidate = <SID>IsCandidate(a:prev_matches, l:_line[0], l:col_number)
                    if l:start_col_of_candidate != -1
                        if l:_char == a:char
                            " adding the location of the match
                            call add(l:results, [l:_line[0], l:start_col_of_candidate, l:col_number])
                        endif
                    endif
                    let l:col_number += 1
                endfor
            endfor
            return l:results
        endfunction

        function! s:GetVisibleLines(start_line, end_line)
            let l:visible_lines = []
            let l:current_line = a:start_line
            while l:current_line != a:end_line
                " if the line is folded, continue.
                if foldclosed(l:current_line) != -1
                    let l:current_line += 1
                    continue
                endif

                call add(l:visible_lines, [l:current_line, getline(l:current_line)])
                let l:current_line += 1
            endwhile
            return l:visible_lines
        endfunction

        function! s:UniquelifyDuplicates(lines, matches, duplicates)
            let l:new_matches = []

            for l:_match in a:matches
                let l:match_as_string = <SID>GetLineByNumber(a:lines, l:_match[0])[1][l:_match[1]:l:_match[2]]

                let l:current_duplicates = []
                for l:_dup in a:duplicates
                    let l:dup_as_string = <SID>GetLineByNumber(a:lines, l:_dup[0])[1][l:_dup[1]:l:_dup[2]]

                    if l:dup_as_string == l:match_as_string
                        call add(l:current_duplicates, l:_dup)
                    endif
                endfor

                " ignore non duplicates
                if len(l:current_duplicates) == 0
                    call add(l:new_matches, l:_match)
                    continue
                endif

                " insert duplicates in unique way by chnaging its length
                " all duplicates are the same, take the first one.
                let l:new_length = 0
                for l:_dup in l:current_duplicates
                    call add(l:new_matches, [l:_dup[0], l:_dup[1], l:_dup[1] + l:new_length])

                    " make sure we do not go beyond boundries
                    let l:line = <SID>GetLineByNumber(a:lines, l:_dup[0])[1]
                    if l:_dup[1] + l:new_length < len(l:line)
                        let l:new_length += 1
                    endif
                endfor
            endfor
            return l:new_matches
        endfunction

        function! s:Jumper()
            " line number, start column number, end column number
            let l:matches = [[-1,-1,-1]]

            let l:start_line = line('w0')
            let l:end_line = line('w$')

            let l:duplicates = [[line('.') - l:start_line, col('.')]]
            let l:visible_lines = <SID>GetVisibleLines(l:start_line, l:end_line)

            while 1
                let l:user_char_number = getchar()
                " if user press ESC
                if l:user_char_number == 27
                    if len(l:duplicates) == 0
                        break
                    endif
                    call setpos('.', [0, l:duplicates[0][0], l:duplicates[0][1], 0])
                    break
                " if user press ENTER
                elseif l:user_char_number == 13
                    let l:matches = <SID>GetEndOfLineMatches(l:visible_lines, l:matches)
                " if user press valid character
                else
                    let l:user_char = nr2char(l:user_char_number)
                    let l:matches = <SID>SearchLines(l:visible_lines, l:user_char, l:matches)
                endif

                " this will expand the matches until the next uniqe way to
                " identify itself.
                let l:expand_result = <SID>ExpandMatches(l:visible_lines, l:matches)
                let l:matches = l:expand_result[0]
                let l:duplicates = l:expand_result[1]

                " this will make the duplicates distinguisables
                let l:matches = <SID>UniquelifyDuplicates(l:visible_lines, l:matches, l:duplicates)

                " if found move cursor
                if len(l:matches) == 1
                    call setpos('.', [0, l:matches[0][0], l:matches[0][1] + 1, 0 ])
                    break
                elseif len(l:matches) == 0
                    break
                endif

                call <SID>HighlightMatches(l:matches)
            endwhile

            " clearing the highlight we made.
            highlight clear
            call clearmatches()
        endfunction

        function! s:GetLineByNumber(lines, line_number)
            for l:line in a:lines
                if l:line[0] == a:line_number
                    return l:line
                endif
            endfor
            return [-1]
        endfunction

        function! s:HighlightMatches(matches)
            " clear everything before highlight new.
            highlight clear
            call clearmatches()

            highlight Jumper_1 ctermfg=black ctermbg=green
            highlight Jumper_2 ctermfg=black ctermbg=blue

            for l:_match in a:matches
                let l:line = l:_match[0]
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
                let l:_match_str = <SID>GetLineByNumber(a:lines, l:_match[0])[1][l:_match[1]:]

                let l:longest_match = 0
                let l:multiple_matches = 0
                for l:__match in a:matches
                    " ignore if the same match
                    if l:__match[0] == l:_match[0] && l:__match[1] == l:_match[1] && l:__match[2] == l:__match[2]
                        continue
                    endif

                    let l:__match_str = <SID>GetLineByNumber(a:lines, l:__match[0])[1][l:__match[1]:]

                    let l:current_match_len = 0

                    let l:loop_len = len(l:_match_str)
                    while l:current_match_len < l:loop_len
                        if l:_match_str[l:current_match_len] != l:__match_str[l:current_match_len]
                            break
                        endif
                        let l:current_match_len += 1
                    endwhile

                    " check if we got to the end of the line.
                    " if we did we have duplicates
                    if l:current_match_len == len(l:_match_str)
                        let l:multiple_matches = 1
                        let l:longest_match = l:current_match_len
                    elseif l:current_match_len > l:longest_match
                        let l:longest_match = l:current_match_len
                        let l:multiple_matches = 0
                    elseif l:current_match_len == l:longest_match && l:__match_str[l:current_match_len] == l:_match_str[l:current_match_len]
                        let l:multiple_matches = 1
                    endif
                endfor

                " adding the new expanded match
                call add(l:new_matches, [l:_match[0], l:_match[1], l:_match[1] + l:longest_match])

                " if there are multiple matches add it to the duplicates so we
                " can uniquely identify them later.
                if l:multiple_matches == 1
                    call add(l:duplicates, [l:_match[0], l:_match[1], l:_match[1] + l:longest_match])
                endif

                " if l:longest_match == len(l:_match_str) || l:multiple_matches == 1
                    " let l:found_in_duplicates = 0
                    " " add to matches if the first one
                    " for l:dup in l:duplicates
                        " if l:dup[0] == l:_match[0] && l:dup[1] == l:_match[1]
                            " let l:found_in_duplicates = 1
                            " break
                        " endif
                    " endfor

                    " " add only the first to the matches.
                    " if l:found_in_duplicates == 0
                        " call add(l:new_matches, [l:_match[0], l:_match[1], l:_match[1] + l:longest_match])
                    " endif

                    " call add(l:duplicates, [l:_match[0], l:_match[1]])
                " else
                    " adding the new expanded match
                    " call add(l:new_matches, [l:_match[0], l:_match[1], l:_match[1] + l:longest_match])
                " endif
            endfor
            return [l:new_matches, l:duplicates]
        endfunction

        function! s:AllMatchesTheSame(lines, matches)
            " getting the first match to compare
            let l:line = <SID>GetLineByNumber(a:lines, a:matches[0][0])
            let l:memory = l:line[1][a:matches[0][1]:a:matches[0][2]]

            for l:_match in a:matches
                let l:curr_line = <SID>GetLineByNumber(a:lines, l:_match[0])
                if l:curr_line[0] == -1
                    continue
                endif
                let l:_match_str = l:curr_line[1][l:_match[1]:l:_match[2]]
                if l:memory != l:_match_str
                    return 0
                endif
            endfor
            return 1
        endfunction

        function! s:GetEndOfLineMatches(lines, prev_matches)
            let l:results = []

            for l:_match in a:prev_matches
                let l:line = <SID>GetLineByNumber(a:lines, l:_match[0])

                " the match is pointing to the end of the line
                if len(l:line[1]) == l:_match[2]
                    call add(l:results, l:_match)
                endif
            endfor

            return l:results
        endfunction

        function! s:SearchLines(lines, char, prev_matches)
            let l:results = []

            for l:_line in a:lines
                let l:col_number = 0
                for l:_char in split(l:_line[1], '\zs')
                    let l:start_col_of_candidate = <SID>IsCandidate(a:prev_matches, l:_line[0], l:col_number)
                    if l:start_col_of_candidate != -1
                        if l:_char == a:char
                            " adding the location of the match
                            call add(l:results, [l:_line[0], l:start_col_of_candidate, l:col_number])
                        endif
                    endif
                    let l:col_number += 1
                endfor
            endfor
            return l:results
        endfunction

        function! s:GetVisibleLines(start_line, end_line)
            let l:visible_lines = []
            let l:current_line = a:start_line
            while l:current_line != a:end_line
                " if the line is folded, continue.
                if foldclosed(l:current_line) != -1
                    let l:current_line += 1
                    continue
                endif

                call add(l:visible_lines, [l:current_line, getline(l:current_line)])
                let l:current_line += 1
            endwhile
            return l:visible_lines
        endfunction

        function! s:UniquelifyDuplicates(lines, matches, duplicates)
            let l:new_matches = []

            for l:_match in a:matches
                let l:match_as_string = <SID>GetLineByNumber(a:lines, l:_match[0])[1][l:_match[1]:l:_match[2]]

                let l:current_duplicates = []
                for l:_dup in a:duplicates
                    let l:dup_as_string = <SID>GetLineByNumber(a:lines, l:_dup[0])[1][l:_dup[1]:l:_dup[2]]

                    if l:dup_as_string == l:match_as_string
                        call add(l:current_duplicates, l:_dup)
                    endif
                endfor

                " ignore non duplicates
                if len(l:current_duplicates) == 0
                    call add(l:new_matches, l:_match)
                    continue
                endif

                " insert duplicates in unique way by chnaging its length
                " all duplicates are the same, take the first one.
                let l:new_length = 0
                for l:_dup in l:current_duplicates
                    call add(l:new_matches, [l:_dup[0], l:_dup[1], l:_dup[1] + l:new_length])

                    " make sure we do not go beyond boundries
                    let l:line = <SID>GetLineByNumber(a:lines, l:_dup[0])[1]
                    if l:_dup[1] + l:new_length < len(l:line)
                        let l:new_length += 1
                    endif
                endfor
            endfor
            return l:new_matches
        endfunction

        function! s:Jumper()
            " line number, start column number, end column number
            let l:matches = [[-1,-1,-1]]

            let l:start_line = line('w0')
            let l:end_line = line('w$')

            let l:duplicates = [[line('.') - l:start_line, col('.')]]
            let l:visible_lines = <SID>GetVisibleLines(l:start_line, l:end_line)

            while 1
                let l:user_char_number = getchar()
                " if user press ESC
                if l:user_char_number == 27
                    if len(l:duplicates) == 0
                        break
                    endif
                    call setpos('.', [0, l:duplicates[0][0], l:duplicates[0][1], 0])
                    break
                " if user press ENTER
                elseif l:user_char_number == 13
                    let l:matches = <SID>GetEndOfLineMatches(l:visible_lines, l:matches)
                " if user press valid character
                else
                    let l:user_char = nr2char(l:user_char_number)
                    let l:matches = <SID>SearchLines(l:visible_lines, l:user_char, l:matches)
                endif

                " this will expand the matches until the next uniqe way to
                " identify itself.
                let l:expand_result = <SID>ExpandMatches(l:visible_lines, l:matches)
                let l:matches = l:expand_result[0]
                let l:duplicates = l:expand_result[1]

                " this will make the duplicates distinguisables
                let l:matches = <SID>UniquelifyDuplicates(l:visible_lines, l:matches, l:duplicates)

                " if found move cursor
                if len(l:matches) == 1
                    call setpos('.', [0, l:matches[0][0], l:matches[0][1] + 1, 0 ])
                    break
                elseif len(l:matches) == 0
                    break
                endif

                call <SID>HighlightMatches(l:matches)
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

        " -- Doc Operator Implementation

            function! s:GetSelected(start_range, end_range)
                " Why is this not a built-in Vim script function?!
                let [line_start, column_start] = getpos(a:start_range)[1:2]
                let [line_end, column_end] = getpos(a:end_range)[1:2]
                let lines = getline(line_start, line_end)
                if len(lines) == 0
                    return ''
                endif
                let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
                let lines[0] = lines[0][column_start - 1:]
                return join(lines, "\n")
            endfunction

            function! s:MainDocOperator(start_range, end_range)
                let l:selected = <SID>GetSelected(a:start_range, a:end_range)
                let l:to_doc = "[".strftime('%Y-%m-%d %H:%M:%S')."] [CODE] ".expand('%:p').":".line('.')."\n"
                let l:to_doc = l:to_doc."```".&filetype."\n"
                let l:to_doc = l:to_doc.l:selected."\n"
                let l:to_doc = l:to_doc."```"

                " --------------------------------------------------------------------------------
                " append to doc file
                " --------------------------------------------------------------------------------
                new
                setlocal buftype=nofile bufhidden=hide noswapfile nobuflisted
                put=l:to_doc
                execute 'w >> ~/doc.md'
                q
                " --------------------------------------------------------------------------------
            endfunction

            function! s:DocOperator(type)
                " Save unnamed register's content
                let l:saved_unnamed_register = @@

                if a:type ==# 'v'
                    let l:start_range = "'<"
                    let l:end_range = "'>"

                    call <SID>MainDocOperator(l:start_range, l:end_range)
                elseif a:type ==# 'V'
                    let l:start_range = "'<"
                    let l:end_range = "'>"

                    call <SID>MainDocOperator(l:start_range, l:end_range)
                elseif a:type ==# "\<c-v>"                          " Visuall Block mode
                    let l:start_range = "'<"
                    let l:end_range = "'>"

                    call <SID>MainDocOperator(l:start_range, l:end_range)
                elseif a:type ==# 'line'
                    let l:start_range = "'["
                    let l:end_range = "']"

                    call <SID>MainDocOperator(l:start_range, l:end_range)
                elseif a:type ==# 'char'
                    let l:start_range = "'["
                    let l:end_range = "']"

                    call <SID>MainDocOperator(l:start_range, l:end_range)
                endif

                " Restore unnamed register's content
                let @@ = l:saved_unnamed_register
            endfunction

        " -- Comment Operator Implementation

            function! s:GetCommentSyntaxCommentOperator()
                " default will be #
                let l:comment_syntax = "#"

                if &filetype ==# 'python'
                    let l:comment_syntax = "#"
                elseif &filetype ==# 'vim'
                    let l:comment_syntax = "\""
                elseif &filetype ==# 'javascript'
                    let l:comment_syntax = "//"
                elseif &filetype ==# 'conf'
                    let l:comment_syntax = "#"
                elseif &filetype ==# 'c'
                    let l:comment_syntax = "//"
                elseif &filetype ==# 'cpp'
                    let l:comment_syntax = "//"
                elseif &filetype ==# 'rust'
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
                        let l:current_line = l:current_line + 1
                        continue
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

        " -- Printer Operator Implementation

            function! s:GetPrintSyntaxPrinterOperator()
                let l:print_syntax_start = ""
                let l:print_syntax_end = ""

                if &filetype ==# 'python'
                    let l:print_syntax_start = "print('{}'.format("
                    let l:print_syntax_end = "))"
                    let l:end_cursor_postion = 8
                elseif &filetype ==# 'c'
                    let l:print_syntax_start = "printf(\"\", "
                    let l:print_syntax_end = ");"
                    let l:end_cursor_postion = 9
                elseif &filetype ==# 'vim'
                    let l:print_syntax_start = "echomsg "
                    let l:print_syntax_end = ""
                    let l:end_cursor_postion = 8
                endif

                return [l:print_syntax_start, l:print_syntax_end, l:end_cursor_postion]
            endfunction

            function! s:MainPrinterOperator(start_range, end_range)
                if line(a:start_range) != line(a:end_range)
                    return
                endif

                let l:to_print = getline(line(a:start_range))
                let l:to_print = l:to_print[col(a:start_range) - 1:col(a:end_range) - 1]

                echomsg l:to_print

                let l:print_syntax_start = <SID>GetPrintSyntaxPrinterOperator()[0]
                let l:print_syntax_end = <SID>GetPrintSyntaxPrinterOperator()[1]
                let l:end_cursor_position = <SID>GetPrintSyntaxPrinterOperator()[2]

                let l:line_to_append = l:print_syntax_start.l:to_print.l:print_syntax_end

                " getting the current indentation level
                let l:indent_level = indent(line("."))

                " adding spaces to match indentation.
                while l:indent_level > 0
                    let l:line_to_append = ' '.l:line_to_append
                    let l:indent_level -= 1
                endwhile

                " this append the line below the cursor
                call append(line('.'), [l:line_to_append])

                " move the string location
                call setpos('.', [0, line('.') + 1, l:end_cursor_position + indent(line('.')), 0])
            endfunction

            function! s:PrinterOperator(type)
                " Save unnamed register's content
                let l:saved_unnamed_register = @@

                if a:type ==# 'v'
                    let l:start_range = "'<"
                    let l:end_range = "'>"

                    call <SID>MainPrinterOperator(l:start_range, l:end_range)
                elseif a:type ==# 'V'
                    let l:start_range = "'<"
                    let l:end_range = "'>"

                    call <SID>MainPrinterOperator(l:start_range, l:end_range)
                elseif a:type ==# "\<c-v>"                          " Visuall Block mode
                    let l:start_range = "'<"
                    let l:end_range = "'>"

                    call <SID>MainPrinterOperator(l:start_range, l:end_range)
                elseif a:type ==# 'line'
                    let l:start_range = "'["
                    let l:end_range = "']"

                    call <SID>MainPrinterOperator(l:start_range, l:end_range)
                elseif a:type ==# 'char'
                    let l:start_range = "'["
                    let l:end_range = "']"

                    call <SID>MainPrinterOperator(l:start_range, l:end_range)
                endif

                " Restore unnamed register's content
                let @@ = l:saved_unnamed_register
            endfunction

    " " --- Language Server Protocol ---

        " " TODO: neovim is not there yet...

        " function! LSPStartClient()
            " " lua << EOF
                " " config = {
                    " " cmd = {"pyls"};
                    " " filetypes = {"python"};
                    " " root_dir = "/s/All-In-One";
                " " }
                " " vim.lsp.start_client(config)
            " " EOF
        " endfunction

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

lua require('s')
