""" ---- Plug configuration ----  

    " " - For Neovim: stdpath('data') . '/plugged'
    " call plug#begin(stdpath('data') . '/plugged')

        " Plug 'neovim/nvim-lsp'

    " call plug#end()


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
    set relativenumber          " setting relative numbers
    set foldmethod=indent       " setting folding to indentations
    set foldlevel=20            " unfold all folds by default
    set foldignore=             " this is to ignore the # when folding!! so goood!!!
    set splitright              " split to the right.
    set splitbelow              " the default split direction will be at the bottom
    set mouse=a                 " enable mouse support (selection, resize).
    set tags=tags               " enable ctags
    set clipboard+=unnamedplus

    " -- Status Line --
    set statusline=
    set statusline+=\ %M        " is the file has being modified?
    set statusline+=\ %y        " the file type
    set statusline+=\ %r        " is read-only?
    set statusline+=\ %f        " relative file path
    set statusline+=%=          " all settings after this are alligned right
    set statusline+=\ %l:%c     " show line:column
    set statusline+=\ [%p%%]    " the precentage we in the file

    " whitespace characters
    " do 'set list/nolist' to show/hide whitespace characters
    " set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
    " set listchars=eol:¬,tab:>·

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
    " lua require'nvim_lsp'.pyls.setup{}

    " " Enable vimscript languge server
    " lua require'nvim_lsp'.vimls.setup{}

    " " Enable c language server
    " lua require'nvim_lsp'.clangd.setup{}


""" ---- Colorscheme! ----

    " somehow the only shceme that actualy worked for me in all
    " use cases is the default one... WTF?
    " colorscheme default
    colorscheme monokai


""" ---- Bindings ----

    " Disable search highlights until next search at <esc> press.
    nnoremap <esc> :nohlsearch<return><esc>

    " Bind tab to fold toggle.
    nnoremap <tab> za

    " Bind <C-i> to <M-o>
    nnoremap <M-o> <C-i>

    " Resizing
    nnoremap <C-k> :resize +6<CR>
    nnoremap <C-j> :resize -6<CR>
    " change the mapping of the redraw
    nnoremap <C-l> :vertical resize +6<CR> 
    nnoremap <C-h> :vertical resize -6<CR>

    " Change indentation and keep visualized!
    vnoremap > >gv
    vnoremap < <gv
    
    " paste only what yanked and not deleted before.
    " *** in visual mode only ***
    vnoremap p "0p

    " Search for visually selected text
    vnoremap / y/\V<C-R>=escape(@",'/\')<CR><CR>

    """ --- Language Server Bindings ---

        " nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
        " nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
        " nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
        " nnoremap <silent> gD    <cmd>lua vim.lsp.buf.type_definition()<CR>

        " nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
        " nnoremap <silent> gh    <cmd>lua vim.lsp.buf.hover()<CR>
        " nnoremap <silent> gx    <cmd>lua vim.lsp.buf.references()<CR>

    """ --- Cscope Bindings ---

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
            
        " -- Draw commands --

            " use the default keymaps <C-L> to redraw the screen.
            " for some reason there is a difference between :redraw! to the 
            " default <C-L> behaviour.
            nnoremap <leader>d <C-L>

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

        " -- Toggle commands --

        " -- Find commands --

            nnoremap <leader>f :call <SID>Jumper()<CR>

        " -- Search commands --
           
            " [Search File] 
            nnoremap <leader>sf :call <SID>FZFLaunch()<CR>

            " [Search Content in files] 
            nnoremap <leader>sc :call <SID>RipGrepLaunch(0)<CR>
            vnoremap <leader>sc :call <SID>RipGrepLaunch(1)<CR>

    """ --- Custom Operators Bindings ---
        
        " -- Surround Operator

            nnoremap <silent> cs :call <SID>ChangeSurroundOperator()<cr>
            nnoremap <silent> gs :<C-u>set operatorfunc=<SID>GoSurroundOperator<CR>g@
            vnoremap <silent> gs :<C-u>call <SID>GoSurroundOperator(visualmode())<CR>

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

                " entering insert mode after the terminal is launched.
                normal i
            endfunction

        " --- FZF ---

            function! FZFOnExit()
                execute "silent! normal! ".":e ".g:terminal_content[0]."\r"
            endfunction

            function! s:FZFLaunch()
                call TerminalLaunch("fzf", "silent! normal! :call FZFOnExit()\r", 0, 0, 0)
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
                    call TerminalLaunch("rg --vimgrep ".l:to_search, "silent! normal! :call RipGrepOnExit()\r", 2, 1, 0)
                endif
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
                " default will be #
                let l:comment_syntax = "#"
                
                if &filetype ==# 'python'
                    let l:comment_syntax = "#"
                elseif &filetype ==# 'vim'
                    let l:comment_syntax = "\""
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

        " " -- Python Text Objects

            " function! s:NormalMovePyTextObject(python_statement_pattern, to_next, count)
                " " Save the user's wrapscan settings.
                " let l:saved_wrapscan = &wrapscan

                " let &wrapscan = 0

                " let l:direction = '/'
                " if a:to_next ==# 0
                    " let l:direction = '?'
                " endif

                " execute "silent! normal! ".l:direction.'\v'.a:python_statement_pattern."\r"

                " " Repeat the search \<count\> times.
                " execute "silent! normal! ".repeat("n", a:count - 1)
                
                " " Return the user's wrapscan settings.
                " let &wrapscan=l:saved_wrapscan
            " endfunction

            " function! s:VisualMovePyTextObject(python_statement_pattern, to_next, count)
                " normal! gv
                " call <SID>NormalMovePyTextObject(a:python_statement_pattern, a:to_next, a:count)
            " endfunction

            " function! s:OperPendPyTextObject(python_statement_pattern, to_next, count)
                " normal! v
                " call NormalMovePyTextObject(a:python_statement_pattern, a:to_next, a:count)
                " normal! k$
            " endfunction

            " function! s:InnerOuterPyTextObject(python_statement_pattern, count, is_inner)
                " " Save the user's wrapscan settings.
                " let l:saved_wrapscan = &wrapscan

                " let &wrapscan = 0

                " execute "silent! normal! l"

                " let l:start_indent_level = indent(line("."))

                " " Got to previous for decleration
                " execute "silent! normal! ".'?\v'.a:python_statement_pattern."\r"

                " let l:indent_level = indent(line("."))

                " while l:indent_level >= l:start_indent_level
                    " execute "silent! normal! n"
                    " let l:indent_level = indent(line("."))
                " endwhile

                " let l:command = "jV"
                " if a:is_inner ==# 0
                    " let l:command = "Vj"
                " endif
                " execute "silent! normal! ".l:command

                " " Keep down until indentation no longer fit
                " let l:inner_indent_level = indent(line("."))

                " let l:is_end_of_file = 0
                " while 1
                    " execute "silent! normal! j"
                    " let l:inner_indent_level = indent(line("."))

                    " " Check if end of file
                    " if line(".") ==# line("$")
                        " let l:is_end_of_file = 1
                        " break
                    " endif

                    " if l:inner_indent_level <= l:indent_level
                        " if match(getline(line(".")), "^\\s*$") < 0
                            " break
                        " endif
                    " endif
                " endwhile

                " if l:is_end_of_file ==# 0
                    " execute "silent! normal! k"
                " endif

                " " Keep up until not an empty line
                " while match(getline(line(".")), "^\\s*$") > -1
                    " execute "silent! normal! k"
                " endwhile

                " execute "silent! normal! $"

                " " Return the user's wrapscan settings.
                " let &wrapscan=l:saved_wrapscan
            " endfunction

            " function! s:InnerOuterStatementPyTextObject(python_statement_pattern, count, is_inner)
                " " Save the user's wrapscan settings.
                " let l:saved_wrapscan = &wrapscan

                " let &wrapscan = 0
                " execute "silent! normal! l"

                " let l:start_indent_level = indent(line("."))

                " " Got to previous for decleration
                " execute "silent! normal! ".'?\v'.a:python_statement_pattern."\r"

                " let l:indent_level = indent(line("."))
                " while l:indent_level >= l:start_indent_level
                    " execute "silent! normal! n"
                    " let l:indent_level = indent(line("."))
                " endwhile

                " if a:is_inner ==# 1
                    " execute "silent! normal! "."w"
                " endif

                " execute "silent! normal! "."v/:\rh"

                " " Return the user's wrapscan settings.
                " let &wrapscan=l:saved_wrapscan
            " endfunction
                        

            " " -- Binding examples

                " " -- Python Text Objects
                    
                    " " Python for loop text object

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

                    " " Python while loop text object

                        " let g:python_while_pattern = 'while .*:$'

                        " " Motion

                            " autocmd FileType python nnoremap <buffer> <silent> <M-e> :<c-u>call <SID>NormalMovePyTextObject(g:python_while_pattern, 1, v:count)<cr>
                            " autocmd FileType python onoremap <buffer> <silent> <M-e> :call <SID>OperPendPyTextObject(g:python_while_pattern, 1, v:count)<cr>
                            " autocmd FileType python vnoremap <buffer> <silent> <M-e> :<c-u>call <SID>VisualMovePyTextObject(g:python_while_pattern, 1, v:count)<cr>

                            " autocmd FileType python nnoremap <buffer> <silent> <M-E> :<c-u>call <SID>NormalMovePyTextObject(g:python_while_pattern, 0, v:count)<cr>
                            " autocmd FileType python onoremap <buffer> <silent> <M-E> :call <SID>OperPendPyTextObject(g:python_while_pattern, 0, v:count)<cr>
                            " autocmd FileType python vnoremap <buffer> <silent> <M-E> :<c-u>call <SID>VisualMovePyTextObject(g:python_while_pattern, 0, v:count)<cr>

                        " " Text Object Selection

                            " autocmd FileType python onoremap <buffer> <silent> ie :<c-u>call <SID>InnerOuterPyTextObject(g:python_while_pattern, v:count, 1)<cr>
                            " autocmd FileType python onoremap <buffer> <silent> ae :<c-u>call <SID>InnerOuterPyTextObject(g:python_while_pattern, v:count, 0)<cr>

                            " autocmd FileType python vnoremap <buffer> <silent> ie :<c-u>call <SID>InnerOuterPyTextObject(g:python_while_pattern, v:count, 1)<cr>
                            " autocmd FileType python vnoremap <buffer> <silent> ae :<c-u>call <SID>InnerOuterPyTextObject(g:python_while_pattern, v:count, 0)<cr>

                            " autocmd FileType python onoremap <buffer> <silent> iE :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_while_pattern, v:count, 1)<cr>
                            " autocmd FileType python onoremap <buffer> <silent> aE :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_while_pattern, v:count, 0)<cr>

                            " autocmd FileType python vnoremap <buffer> <silent> iE :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_while_pattern, v:count, 1)<cr>
                            " autocmd FileType python vnoremap <buffer> <silent> aE :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_while_pattern, v:count, 0)<cr>

                    " " Python if statement text object

                        " let g:python_if_pattern = 'if .*[:\\]$'

                        " " Motion

                            " autocmd FileType python nnoremap <buffer> <silent> <M-f> :<c-u>call <SID>NormalMovePyTextObject(g:python_if_pattern, 1, v:count)<cr>
                            " autocmd FileType python onoremap <buffer> <silent> <M-f> :call <SID>OperPendPyTextObject(g:python_if_pattern, 1, v:count)<cr>
                            " autocmd FileType python vnoremap <buffer> <silent> <M-f> :<c-u>call <SID>VisualMovePyTextObject(g:python_if_pattern, 1, v:count)<cr>

                            " autocmd FileType python nnoremap <buffer> <silent> <M-F> :<c-u>call <SID>NormalMovePyTextObject(g:python_if_pattern, 0, v:count)<cr>
                            " autocmd FileType python onoremap <buffer> <silent> <M-F> :call <SID>OperPendPyTextObject(g:python_if_pattern, 0, v:count)<cr>
                            " autocmd FileType python vnoremap <buffer> <silent> <M-F> :<c-u>call <SID>VisualMovePyTextObject(g:python_if_pattern, 0, v:count)<cr>

                        " " Text Object Selection

                            " autocmd FileType python onoremap <buffer> <silent> if :<c-u>call <SID>InnerOuterPyTextObject(g:python_if_pattern, v:count, 1)<cr>
                            " autocmd FileType python onoremap <buffer> <silent> af :<c-u>call <SID>InnerOuterPyTextObject(g:python_if_pattern, v:count, 0)<cr>

                            " autocmd FileType python vnoremap <buffer> <silent> if :<c-u>call <SID>InnerOuterPyTextObject(g:python_if_pattern, v:count, 1)<cr>
                            " autocmd FileType python vnoremap <buffer> <silent> af :<c-u>call <SID>InnerOuterPyTextObject(g:python_if_pattern, v:count, 0)<cr>

                            " autocmd FileType python onoremap <buffer> <silent> iF :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_if_pattern, v:count, 1)<cr>
                            " autocmd FileType python onoremap <buffer> <silent> aF :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_if_pattern, v:count, 0)<cr>

                            " autocmd FileType python vnoremap <buffer> <silent> iF :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_if_pattern, v:count, 1)<cr>
                            " autocmd FileType python vnoremap <buffer> <silent> aF :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_if_pattern, v:count, 0)<cr>

                    " " Python try statement text object

                        " let g:python_try_pattern = 'try:$'

                        " " Motion

                            " autocmd FileType python nnoremap <buffer> <silent> <M-y> :<c-u>call <SID>NormalMovePyTextObject(g:python_try_pattern, 1, v:count)<cr>
                            " autocmd FileType python onoremap <buffer> <silent> <M-y> :call <SID>OperPendPyTextObject(g:python_try_pattern, 1, v:count)<cr>
                            " autocmd FileType python vnoremap <buffer> <silent> <M-y> :<c-u>call <SID>VisualMovePyTextObject(g:python_try_pattern, 1, v:count)<cr>

                            " autocmd FileType python nnoremap <buffer> <silent> <M-Y> :<c-u>call <SID>NormalMovePyTextObject(g:python_try_pattern, 0, v:count)<cr>
                            " autocmd FileType python onoremap <buffer> <silent> <M-Y> :call <SID>OperPendPyTextObject(g:python_try_pattern, 0, v:count)<cr>
                            " autocmd FileType python vnoremap <buffer> <silent> <M-Y> :<c-u>call <SID>VisualMovePyTextObject(g:python_try_pattern, 0, v:count)<cr>

                        " " Text Object Selection

                            " autocmd FileType python onoremap <buffer> <silent> iy :<c-u>call <SID>InnerOuterPyTextObject(g:python_try_pattern, v:count, 1)<cr>
                            " autocmd FileType python onoremap <buffer> <silent> ay :<c-u>call <SID>InnerOuterPyTextObject(g:python_try_pattern, v:count, 0)<cr>

                            " autocmd FileType python vnoremap <buffer> <silent> iy :<c-u>call <SID>InnerOuterPyTextObject(g:python_try_pattern, v:count, 1)<cr>
                            " autocmd FileType python vnoremap <buffer> <silent> ay :<c-u>call <SID>InnerOuterPyTextObject(g:python_try_pattern, v:count, 0)<cr>

                            " autocmd FileType python onoremap <buffer> <silent> iY :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_try_pattern, v:count, 1)<cr>
                            " autocmd FileType python onoremap <buffer> <silent> aY :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_try_pattern, v:count, 0)<cr>

                            " autocmd FileType python vnoremap <buffer> <silent> iY :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_try_pattern, v:count, 1)<cr>
                            " autocmd FileType python vnoremap <buffer> <silent> aY :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_try_pattern, v:count, 0)<cr>

                    " " Python else statement text object

                        " let g:python_else_pattern = '(else:|elif .*[:\\]$)'

                        " " Motion

                            " autocmd FileType python nnoremap <buffer> <silent> <M-l> :<c-u>call <SID>NormalMovePyTextObject(g:python_else_pattern, 1, v:count)<cr>
                            " autocmd FileType python onoremap <buffer> <silent> <M-l> :call <SID>OperPendPyTextObject(g:python_else_pattern, 1, v:count)<cr>
                            " autocmd FileType python vnoremap <buffer> <silent> <M-l> :<c-u>call <SID>VisualMovePyTextObject(g:python_else_pattern, 1, v:count)<cr>

                            " autocmd FileType python nnoremap <buffer> <silent> <M-L> :<c-u>call <SID>NormalMovePyTextObject(g:python_else_pattern, 0, v:count)<cr>
                            " autocmd FileType python onoremap <buffer> <silent> <M-L> :call <SID>OperPendPyTextObject(g:python_else_pattern, 0, v:count)<cr>
                            " autocmd FileType python vnoremap <buffer> <silent> <M-L> :<c-u>call <SID>VisualMovePyTextObject(g:python_else_pattern, 0, v:count)<cr>

                        " " Text Object Selection

                            " autocmd FileType python onoremap <buffer> <silent> il :<c-u>call <SID>InnerOuterPyTextObject(g:python_else_pattern, v:count, 1)<cr>
                            " autocmd FileType python onoremap <buffer> <silent> al :<c-u>call <SID>InnerOuterPyTextObject(g:python_else_pattern, v:count, 0)<cr>

                            " autocmd FileType python vnoremap <buffer> <silent> il :<c-u>call <SID>InnerOuterPyTextObject(g:python_else_pattern, v:count, 1)<cr>
                            " autocmd FileType python vnoremap <buffer> <silent> al :<c-u>call <SID>InnerOuterPyTextObject(g:python_else_pattern, v:count, 0)<cr>

                            " autocmd FileType python onoremap <buffer> <silent> iL :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_else_pattern, v:count, 1)<cr>
                            " autocmd FileType python onoremap <buffer> <silent> aL :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_else_pattern, v:count, 0)<cr>

                            " autocmd FileType python vnoremap <buffer> <silent> iL :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_else_pattern, v:count, 1)<cr>
                            " autocmd FileType python vnoremap <buffer> <silent> aL :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_else_pattern, v:count, 0)<cr>
                            
                    " " Python class text object

                        " let g:python_class_pattern = 'class .*:$'

                        " " Motion

                            " autocmd FileType python nnoremap <buffer> <silent> <M-s> :<c-u>call <SID>NormalMovePyTextObject(g:python_class_pattern, 1, v:count)<cr>
                            " autocmd FileType python onoremap <buffer> <silent> <M-s> :call <SID>OperPendPyTextObject(g:python_class_pattern, 1, v:count)<cr>
                            " autocmd FileType python vnoremap <buffer> <silent> <M-s> :<c-u>call <SID>VisualMovePyTextObject(g:python_class_pattern, 1, v:count)<cr>

                            " autocmd FileType python nnoremap <buffer> <silent> <M-S> :<c-u>call <SID>NormalMovePyTextObject(g:python_class_pattern, 0, v:count)<cr>
                            " autocmd FileType python onoremap <buffer> <silent> <M-S> :call <SID>OperPendPyTextObject(g:python_class_pattern, 0, v:count)<cr>
                            " autocmd FileType python vnoremap <buffer> <silent> <M-S> :<c-u>call <SID>VisualMovePyTextObject(g:python_class_pattern, 0, v:count)<cr>

                        " " Text Object Selection

                            " autocmd FileType python onoremap <buffer> <silent> ic :<c-u>call <SID>InnerOuterPyTextObject(g:python_class_pattern, v:count, 1)<cr>
                            " autocmd FileType python onoremap <buffer> <silent> ac :<c-u>call <SID>InnerOuterPyTextObject(g:python_class_pattern, v:count, 0)<cr>

                            " autocmd FileType python vnoremap <buffer> <silent> ic :<c-u>call <SID>InnerOuterPyTextObject(g:python_class_pattern, v:count, 1)<cr>
                            " autocmd FileType python vnoremap <buffer> <silent> ac :<c-u>call <SID>InnerOuterPyTextObject(g:python_class_pattern, v:count, 0)<cr>

                            " autocmd FileType python onoremap <buffer> <silent> iC :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_class_pattern, v:count, 1)<cr>
                            " autocmd FileType python onoremap <buffer> <silent> aC :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_class_pattern, v:count, 0)<cr>

                            " autocmd FileType python vnoremap <buffer> <silent> iC :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_class_pattern, v:count, 1)<cr>
                            " autocmd FileType python vnoremap <buffer> <silent> aC :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_class_pattern, v:count, 0)<cr>

                    " " Python method/function text object

                        " let g:python_method_pattern = 'def .*:$'

                        " " Motion

                            " autocmd FileType python nnoremap <buffer> <silent> <M-m> :<c-u>call <SID>NormalMovePyTextObject(g:python_method_pattern, 1, v:count)<cr>
                            " autocmd FileType python onoremap <buffer> <silent> <M-m> :call <SID>OperPendPyTextObject(g:python_method_pattern, 1, v:count)<cr>
                            " autocmd FileType python vnoremap <buffer> <silent> <M-m> :<c-u>call <SID>VisualMovePyTextObject(g:python_method_pattern, 1, v:count)<cr>

                            " autocmd FileType python nnoremap <buffer> <silent> <M-M> :<c-u>call <SID>NormalMovePyTextObject(g:python_method_pattern, 0, v:count)<cr>
                            " autocmd FileType python onoremap <buffer> <silent> <M-M> :call <SID>OperPendPyTextObject(g:python_method_pattern, 0, v:count)<cr>
                            " autocmd FileType python vnoremap <buffer> <silent> <M-M> :<c-u>call <SID>VisualMovePyTextObject(g:python_method_pattern, 0, v:count)<cr>

                        " " Text Object Selection

                            " autocmd FileType python onoremap <buffer> <silent> im :<c-u>call <SID>InnerOuterPyTextObject(g:python_method_pattern, v:count, 1)<cr>
                            " autocmd FileType python onoremap <buffer> <silent> am :<c-u>call <SID>InnerOuterPyTextObject(g:python_method_pattern, v:count, 0)<cr>

                            " autocmd FileType python vnoremap <buffer> <silent> im :<c-u>call <SID>InnerOuterPyTextObject(g:python_method_pattern, v:count, 1)<cr>
                            " autocmd FileType python vnoremap <buffer> <silent> am :<c-u>call <SID>InnerOuterPyTextObject(g:python_method_pattern, v:count, 0)<cr>

                            " autocmd FileType python onoremap <buffer> <silent> iM :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_method_pattern, v:count, 1)<cr>
                            " autocmd FileType python onoremap <buffer> <silent> aM :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_method_pattern, v:count, 0)<cr>

                            " autocmd FileType python vnoremap <buffer> <silent> iM :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_method_pattern, v:count, 1)<cr>
                            " autocmd FileType python vnoremap <buffer> <silent> aM :<c-u>call <SID>InnerOuterStatementPyTextObject(g:python_method_pattern, v:count, 0)<cr>

        " " -- C Text  Objects

            " function! s:NormalMoveCTextObject(c_statement_pattern, to_next, count)
                " " Save the user's wrapscan settings.
                " let l:saved_wrapscan = &wrapscan

                " let &wrapscan = 0

                " let l:direction = '/'
                " if a:to_next ==# 0
                    " let l:direction = '?'
                " endif

                " execute "silent! normal! ".l:direction.'\v'.a:c_statement_pattern."\r"

                " " Repeat the search \<count\> times.
                " execute "silent! normal! ".repeat("n", a:count - 1)
                
                " " Return the user's wrapscan settings.
                " let &wrapscan=l:saved_wrapscan
            " endfunction

            " function! s:VisualMoveCTextObject(c_statement_pattern, to_next, count)
                " normal! gv
                " call <SID>NormalMoveCTextObject(a:c_statement_pattern, a:to_next, a:count)
            " endfunction

            " function! s:OperPendCTextObject(c_statement_pattern, to_next, count)
                " normal! v
                " call NormalMoveCTextObject(a:c_statement_pattern, a:to_next, a:count)
                " normal! k$
            " endfunction

            " function! s:InnerOuterCTextObject(c_statement_pattern, count, is_inner)
                " " Save the user's wrapscan settings.
                " let l:saved_wrapscan = &wrapscan

                " let &wrapscan = 0

                " execute "silent! normal! $"

                " " Got to previous for decleration
                " execute "silent! normal! ".'?\v'.a:c_statement_pattern."\r"

                " let &whichwrap = "lh"
                " if a:is_inner
                    " execute "silent! normal! ".'/\v'.'\{'."\r"
                    " execute "silent! normal! lv"
                    " execute "silent! normal! h%h"
                " else
                    " execute "silent! normal! ^v"
                    " execute "silent! normal! ".'/\v'.'\{'."\r"
                    " execute "silent! normal! %"
                " endif
                " let &whichwrap = ""

                " " Return the user's wrapscan settings.
                " let &wrapscan=l:saved_wrapscan
            " endfunction

            " function! s:InnerOuterStatementCTextObject(c_statement_pattern, count, is_inner)
                " " Save the user's wrapscan settings.
                " let l:saved_wrapscan = &wrapscan

                " let &wrapscan = 0

                " execute "silent! normal! $"

                " " Got to previous for decleration
                " execute "silent! normal! ".'?\v'.a:c_statement_pattern."\r"

                " let &whichwrap = "lh"
                " if a:is_inner
                    " " get current line
                    " let l:line = getline('.')

                    " if match(l:line, "^.*().*$") >= 0
                        " " Add space between the parenthesis
                        " execute "silent! normal! f(a \<esc>0"
                    " endif 

                    " execute "silent! normal! f(lvh%h"
                " else
                    " execute "silent! normal! ^vf(%"
                " endif
                " let &whichwrap = ""

                " " Return the user's wrapscan settings.
                " let &wrapscan=l:saved_wrapscan
            " endfunction

            " " -- Binding examples

                " " -- C Text Objects
                    
                    " " C for loop text object

                        " let g:c_for_pattern = "^\\s*for\\s+(.*).*$"

                        " " Motion

                            " autocmd FileType c nnoremap <buffer> <silent> <M-r> :<c-u>call <SID>NormalMoveCTextObject(g:c_for_pattern, 1, v:count)<cr>
                            " autocmd FileType c onoremap <buffer> <silent> <M-r> :call <SID>OperPendCTextObject(g:c_for_pattern, 1, v:count)<cr>
                            " autocmd FileType c vnoremap <buffer> <silent> <M-r> :<c-u>call <SID>VisualMoveCTextObject(g:c_for_pattern, 1, v:count)<cr>

                            " autocmd FileType c nnoremap <buffer> <silent> <M-R> :<c-u>call <SID>NormalMoveCTextObject(g:c_for_pattern, 0, v:count)<cr>
                            " autocmd FileType c onoremap <buffer> <silent> <M-R> :call <SID>OperPendCTextObject(g:c_for_pattern, 0, v:count)<cr>
                            " autocmd FileType c vnoremap <buffer> <silent> <M-R> :<c-u>call <SID>VisualMoveCTextObject(g:c_for_pattern, 0, v:count)<cr>

                        " " Text Object Selection

                            " autocmd FileType c onoremap <buffer> <silent> ir :<c-u>call <SID>InnerOuterCTextObject(g:c_for_pattern, v:count, 1)<cr>
                            " autocmd FileType c onoremap <buffer> <silent> ar :<c-u>call <SID>InnerOuterCTextObject(g:c_for_pattern, v:count, 0)<cr>

                            " autocmd FileType c vnoremap <buffer> <silent> ir :<c-u>call <SID>InnerOuterCTextObject(g:c_for_pattern, v:count, 1)<cr>
                            " autocmd FileType c vnoremap <buffer> <silent> ar :<c-u>call <SID>InnerOuterCTextObject(g:c_for_pattern, v:count, 0)<cr>

                            " autocmd FileType c onoremap <buffer> <silent> iR :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_for_pattern, v:count, 1)<cr>
                            " autocmd FileType c onoremap <buffer> <silent> aR :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_for_pattern, v:count, 0)<cr>

                            " autocmd FileType c vnoremap <buffer> <silent> iR :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_for_pattern, v:count, 1)<cr>
                            " autocmd FileType c vnoremap <buffer> <silent> aR :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_for_pattern, v:count, 0)<cr>

                    " " C while loop text object

                        " let g:c_while_pattern = "^\\s*while\\s+(.*).*$"

                        " " Motion

                            " autocmd FileType c nnoremap <buffer> <silent> <M-e> :<c-u>call <SID>NormalMoveCTextObject(g:c_while_pattern, 1, v:count)<cr>
                            " autocmd FileType c onoremap <buffer> <silent> <M-e> :call <SID>OperPendCTextObject(g:c_while_pattern, 1, v:count)<cr>
                            " autocmd FileType c vnoremap <buffer> <silent> <M-e> :<c-u>call <SID>VisualMoveCTextObject(g:c_while_pattern, 1, v:count)<cr>

                            " autocmd FileType c nnoremap <buffer> <silent> <M-E> :<c-u>call <SID>NormalMoveCTextObject(g:c_while_pattern, 0, v:count)<cr>
                            " autocmd FileType c onoremap <buffer> <silent> <M-E> :call <SID>OperPendCTextObject(g:c_while_pattern, 0, v:count)<cr>
                            " autocmd FileType c vnoremap <buffer> <silent> <M-E> :<c-u>call <SID>VisualMoveCTextObject(g:c_while_pattern, 0, v:count)<cr>

                        " " Text Object Selection

                            " autocmd FileType c onoremap <buffer> <silent> ie :<c-u>call <SID>InnerOuterCTextObject(g:c_while_pattern, v:count, 1)<cr>
                            " autocmd FileType c onoremap <buffer> <silent> ae :<c-u>call <SID>InnerOuterCTextObject(g:c_while_pattern, v:count, 0)<cr>

                            " autocmd FileType c vnoremap <buffer> <silent> ie :<c-u>call <SID>InnerOuterCTextObject(g:c_while_pattern, v:count, 1)<cr>
                            " autocmd FileType c vnoremap <buffer> <silent> ae :<c-u>call <SID>InnerOuterCTextObject(g:c_while_pattern, v:count, 0)<cr>

                            " autocmd FileType c onoremap <buffer> <silent> iE :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_while_pattern, v:count, 1)<cr>
                            " autocmd FileType c onoremap <buffer> <silent> aE :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_while_pattern, v:count, 0)<cr>

                            " autocmd FileType c vnoremap <buffer> <silent> iE :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_while_pattern, v:count, 1)<cr>
                            " autocmd FileType c vnoremap <buffer> <silent> aE :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_while_pattern, v:count, 0)<cr>

                    " " C if text object

                        " let g:c_if_pattern = "^\\s*if\\s+(.*).*$"

                        " " Motion

                            " autocmd FileType c nnoremap <buffer> <silent> <M-f> :<c-u>call <SID>NormalMoveCTextObject(g:c_if_pattern, 1, v:count)<cr>
                            " autocmd FileType c onoremap <buffer> <silent> <M-f> :call <SID>OperPendCTextObject(g:c_if_pattern, 1, v:count)<cr>
                            " autocmd FileType c vnoremap <buffer> <silent> <M-f> :<c-u>call <SID>VisualMoveCTextObject(g:c_if_pattern, 1, v:count)<cr>

                            " autocmd FileType c nnoremap <buffer> <silent> <M-F> :<c-u>call <SID>NormalMoveCTextObject(g:c_if_pattern, 0, v:count)<cr>
                            " autocmd FileType c onoremap <buffer> <silent> <M-F> :call <SID>OperPendCTextObject(g:c_if_pattern, 0, v:count)<cr>
                            " autocmd FileType c vnoremap <buffer> <silent> <M-F> :<c-u>call <SID>VisualMoveCTextObject(g:c_if_pattern, 0, v:count)<cr>

                        " " Text Object Selection

                            " autocmd FileType c onoremap <buffer> <silent> if :<c-u>call <SID>InnerOuterCTextObject(g:c_if_pattern, v:count, 1)<cr>
                            " autocmd FileType c onoremap <buffer> <silent> af :<c-u>call <SID>InnerOuterCTextObject(g:c_if_pattern, v:count, 0)<cr>

                            " autocmd FileType c vnoremap <buffer> <silent> if :<c-u>call <SID>InnerOuterCTextObject(g:c_if_pattern, v:count, 1)<cr>
                            " autocmd FileType c vnoremap <buffer> <silent> af :<c-u>call <SID>InnerOuterCTextObject(g:c_if_pattern, v:count, 0)<cr>

                            " autocmd FileType c onoremap <buffer> <silent> iF :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_if_pattern, v:count, 1)<cr>
                            " autocmd FileType c onoremap <buffer> <silent> aF :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_if_pattern, v:count, 0)<cr>

                            " autocmd FileType c vnoremap <buffer> <silent> iF :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_if_pattern, v:count, 1)<cr>
                            " autocmd FileType c vnoremap <buffer> <silent> aF :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_if_pattern, v:count, 0)<cr>

                    " " C function text object

                        " let g:c_func_pattern = "^\\s*\\w+\\s+[a-zA-Z0-9_\-]+\\(.*\\).*$"

                        " " Motion

                            " autocmd FileType c nnoremap <buffer> <silent> <M-m> :<c-u>call <SID>NormalMoveCTextObject(g:c_func_pattern, 1, v:count)<cr>
                            " autocmd FileType c onoremap <buffer> <silent> <M-m> :call <SID>OperPendCTextObject(g:c_func_pattern, 1, v:count)<cr>
                            " autocmd FileType c vnoremap <buffer> <silent> <M-m> :<c-u>call <SID>VisualMoveCTextObject(g:c_func_pattern, 1, v:count)<cr>

                            " autocmd FileType c nnoremap <buffer> <silent> <M-M> :<c-u>call <SID>NormalMoveCTextObject(g:c_func_pattern, 0, v:count)<cr>
                            " autocmd FileType c onoremap <buffer> <silent> <M-M> :call <SID>OperPendCTextObject(g:c_func_pattern, 0, v:count)<cr>
                            " autocmd FileType c vnoremap <buffer> <silent> <M-M> :<c-u>call <SID>VisualMoveCTextObject(g:c_func_pattern, 0, v:count)<cr>

                        " " Text Object Selection

                            " autocmd FileType c onoremap <buffer> <silent> im :<c-u>call <SID>InnerOuterCTextObject(g:c_func_pattern, v:count, 1)<cr>
                            " autocmd FileType c onoremap <buffer> <silent> am :<c-u>call <SID>InnerOuterCTextObject(g:c_func_pattern, v:count, 0)<cr>

                            " autocmd FileType c vnoremap <buffer> <silent> im :<c-u>call <SID>InnerOuterCTextObject(g:c_func_pattern, v:count, 1)<cr>
                            " autocmd FileType c vnoremap <buffer> <silent> am :<c-u>call <SID>InnerOuterCTextObject(g:c_func_pattern, v:count, 0)<cr>

                            " autocmd FileType c onoremap <buffer> <silent> iM :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_func_pattern, v:count, 1)<cr>
                            " autocmd FileType c onoremap <buffer> <silent> aM :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_func_pattern, v:count, 0)<cr>

                            " autocmd FileType c vnoremap <buffer> <silent> iM :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_func_pattern, v:count, 1)<cr>
                            " autocmd FileType c vnoremap <buffer> <silent> aM :<c-u>call <SID>InnerOuterStatementCTextObject(g:c_func_pattern, v:count, 0)<cr>
