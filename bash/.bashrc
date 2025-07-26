# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# path
export PATH=/home/golf0ned/.local/bin:$PATH

# aliases
source ~/.bash_aliases

# history
export HISTCONTROL=ignoreboth:erasedups
shopt -s histappend

# color prompt
force_color_prompt=yes
PS1="\[\e[38;5;13m\]\u\[\e[38;5;13m\]@\[\e[38;5;13m\]\h \[\e[38;5;14m\]\w \[\033[0m\]$ "

