#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -lah'

# Prompt format
PS1='[\u@\h \W]\$ '

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
    # echo $date_part "|" "$command_part" >> ~/.persistent_history
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
alias ph='tac ~/.persistent_history|fzf'
# bind <ctrl>-p to run the '`ph`' command
bind '"\C-p":"`ph`\n"'

# -------------------------------------------------------------------------------
