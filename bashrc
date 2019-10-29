#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -lah'

# Prompt format
PS1='[\u@\h \W]\$ '

# Configure default editor to be nvim
# Needs to be emacs??? ^^
VISUAL=nvim; export VISUAL EDITOR=nvim; export EDITOR

source ~/git-completion.bash
