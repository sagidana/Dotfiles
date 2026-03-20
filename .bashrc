#
# ~/.bashrc
#

set -o vi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Prompt format
PS1='[\u@\h \W]\n\$ '

# -------------------------------------------------------------------------------
# EDITOR
# -------------------------------------------------------------------------------
# Configure default editor to be nvim
# Needs to be emacs??? ^^
VISUAL=nvim; export VISUAL EDITOR=nvim; export EDITOR
# -------------------------------------------------------------------------------

# -------------------------------------------------------------------------------
# BASH HISTORY
# -------------------------------------------------------------------------------
# When the Bash shell is loaded interactively on user login, it reads the
# contents of the history file into memory. During the shell session, it adds
# content to the in-memory copy of the history.
# When we execute the history command on a terminal, Bash reads the in-memory
# copy to show the history of executed commands. Finally, when the shell exits, it
# writes the in-memory content back to disk on the file pointed by the HISTFILE
# environment variable

# this is the in-memory max num of commands limit
export HISTSIZE=1000000
# this is the history file max num of commands limit
export HISTFILESIZE=1000000
# remove duplicates from history + ignore all commands that starts with space.
# this is usefull in the case we wish to execute commands with sensetive
# information like passwords
export HISTCONTROL=ignoreboth

# # Save history from every terminal opened in the machine!!
# # commands inside PROMPT_COMMAND executes every time the prompt is displayed.
# # basiclly every command we run.
# # 'history -a' is appending any unwritten history to the history file (HISTFILE)
# # 'history -r' is reloading the history from the file (HISTFILE) to in-memory
# # I do not use this because it corrupt the history per terminal
# export PROMPT_COMMAND='history -a; history -r'

# mashed history of all terminals in a single-separated file
# '~/.persistent_history'
# format the history time in the HISTFILE file
#  15  2023-11-03 09:08:29  <command> 1
#  16  2023-11-03 09:08:36  <command> 2
#  17  2023-11-03 09:08:44  <command>
export HISTTIMEFORMAT="%F %T  "

log_bash_persistent_history()
{
  [[
    $(history 1) =~ ^\ *[0-9]+\ +([^\ ]+\ [^\ ]+)\ +(.*)$
  ]]
  local date_part="${BASH_REMATCH[1]}"
  local command_part="${BASH_REMATCH[2]}"
  if [ "$command_part" != "$PERSISTENT_HISTORY_LAST" ]
  then
    echo "$command_part" >> ~/.persistent_history
    export PERSISTENT_HISTORY_LAST="$command_part"
  fi
}
# Stuff to do on PROMPT_COMMAND
run_on_prompt_command()
{
    log_bash_persistent_history
}
export PROMPT_COMMAND="run_on_prompt_command"

persistent_history()
{
    READLINE_LINE=$(tac ~/.persistent_history | fzf --tiebreak=index)
    READLINE_POINT=${#READLINE_LINE}
}
bind -x '"\C-p":persistent_history'
com_doc_rg_head()
{
    RESULTS=$(rg -l --no-heading "$1" -- ~/.commands)
    if [ $? -eq 0 ]; then
        #Set the field separator to new line
        IFS=$'\n'
        for item in $RESULTS
        do
            cat $item | sed -z -n -e 's/==.*$//p'
        done
    fi
}
export -f com_doc_rg_head # this is important so that fzf will have that function

com_doc_fzf_preview()
{
    ARG=$1
    RESULTS=$(rg -l --no-heading -F "${ARG}" -- ~/.commands)
    if [ $? -eq 0 ]; then
        #Set the field separator to new line
        IFS=$'\n'
        for item in $RESULTS
        do
            cat $item | sed -z -n -e 's/^.*==\n//p'
        done
    fi
}
export -f com_doc_fzf_preview # this is important so that fzf will have that function

com_doc()
{
    INITIAL_QUERY=""
    READLINE_LINE=$(FZF_DEFAULT_COMMAND="com_doc_rg_head '$INITIAL_QUERY'" \
            fzf --bind "change:reload:com_doc_rg_head {q} || true" \
                --ansi --phony --query "$INITIAL_QUERY" \
                --preview="com_doc_fzf_preview {}" \
                --preview-window=wrap)
    READLINE_POINT=${#READLINE_LINE}
}
bind -x '"\C-o":com_doc'
knowit_browse()
{
    python /root/projects/knowit/knowit.py -a browse
}
bind -x '"\C-k":knowit_browse'
# -------------------------------------------------------------------------------

# -------------------------------------------------------------------------------
# PATH manipulations
# -------------------------------------------------------------------------------
export PATH=~/scripts/:$PATH
export PATH=~/.local/bin/:$PATH
# -------------------------------------------------------------------------------
#
# -------------------------------------------------------------------------------
# aliases
# -------------------------------------------------------------------------------
alias ls='ls --color=auto'
alias ll='ls -lah'
alias knowit='python ~/github/knowit/knowit.py'
# -------------------------------------------------------------------------------
#
export PYTHONDONTWRITEBYTECODE=1
