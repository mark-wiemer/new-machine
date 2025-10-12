#region Linux Mint gunk (maybe useful)
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
#endregion

# Adapted from https://stackoverflow.com/a/12142066
# https://git-scm.com/docs/git-symbolic-ref
# alias __git_ps1=$(echo git symbolic-ref --short HEAD -q)

#* Scripts
alias bashedit='code ~/.bashrc'
alias bs='npm run build && npm start'
alias brd='bun run dev'
# Git Commit All with Message
alias gcam='git add . && git commit -m $!'
# Git Checkout Main, Pull, New branch
alias gcmpn='git stash && git checkout main && git pull && git new $1'
# Git Diff main Shortstat
alias gds='git diff main --shortstat'
# Delete merged local branches
alias gitdelete='git branch --merged | egrep -v "(^\*|main)" | xargs git branch -d'
# Git Push New branch, works for existing branches as well
alias gpn='git push --set-upstream origin $(__git_ps1 "%s")'
# Git Pull and merge Main
alias gpm='b=$(__git_ps1 "%s") && git checkout main && git pull && git checkout $b && git merge main'
# Git Pull and merge Upstream Main with Ours merge strategy
alias gpumo='b=$(__git_ps1 "%s") && git checkout upstream-main && git pull && git checkout $b && git merge upstream-main -X ours'
alias gsur='git submodule update --remote'
# npm Install with Legacy peer deps
alias npmil='npm i --legacy-peer-deps'
# npm install with version 6, then revert back to version 8
alias npmi6='npm install npm@^6 --global && npm i && npm install npm@^8 --global'
# Create a PR branch to review changes locally
alias pr='git status && git branch -D pr; git checkout -b pr && git reset main'
# Source Bash Run Commands
alias sbrc='source ~/.bashrc'
# Validate CI fix
alias vcf='npm run validate:ci:fix'

# PROMPT
# Yellow current working directory (\w)
# Light blue git branch in parentheses (__git_ps1)
# Pink Node version
# newline
# "$ "
PS1='\[\033[33m\]\w\[\033[36m\]`__git_ps1` \[\033[35m\]Node $(node --version)\[\033[0m\]\n\$ '

# fnm
FNM_PATH="/home/markw/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi
