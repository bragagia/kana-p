#!/usr/bin/env zsh

[[ -z $DISPLAY && $XDG_VTNR -le 3 ]] && (exec startx; exit 0)

autoload -U compinit && compinit
autoload -U colors && colors
setopt HIST_IGNORE_DUPS
setopt completealiases

### Prompt

source ~/.config/zsh/git-prompt.sh
setopt PROMPT_SUBST

function prompt_pwd
{
	pwd | sed "s|^$HOME|~|" | sed "s|^/mnt/|*|" | sed "s|\([/\*]\)|%{$fg_no_bold[white]%}\1%{$fg_bold[red]%}|g"
}

precmd () {print -Pn "\e]0;%n %~ - ZSH\a"}

function my_prompt()
{
    # Username
    pt="%{$fg_bold[blue]%}%n%{$fg_bold[white]%} "

    # Path
    pt="$pt%{$fg_bold[red]%}$(prompt_pwd)"

    # Git
    pt="$pt%{$fg_bold[white]%}$(git_branch)"

    # Suffix
    pt="$pt%{$fg_no_bold[white]%} "

    echo $pt
}

PROMPT='$(my_prompt)'

### Alias

##alias ls='ls --group-directories-first --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias l="ls --color=auto --group-directories-first -lhB --hide='*.[od]'"
alias ll='ls --color=auto --group-directories-first -lah'
alias ne='emacs -nw'
alias cc='gcc -Wall -Wextra -ansi -pedantic -Wno-long-long -Og -g'
alias wee='weechat-curses'
alias blih='blih -u bragag_m'
alias uppity='uppity -X -n kanak'

alias halt='systemctl poweroff'
alias reboot='systemctl reboot'
alias suspend='systemctl suspend'
alias ':q'='exit'

alias rwall='feh --bg-fill -z ~/.walls/active/'

alias mnthdd='sudo mount -U 01CDDABC970F46C0 /mnt/hdd -o rw,uid=kanak,gid=kanak'

cl()
{
	cd $*
	l
}

### create a zkbd compatible hash:w
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=[1~
key[End]=[4~
key[Insert]=[2~]
key[Delete]=[3~
#key[Up]=${terminfo[kcuu1]}
#key[Down]=${terminfo[kcud1]}
#key[Left]=${terminfo[kcub1]}
#key[Right]=${terminfo[kcuf1]}
key[PageUp]=[5~
key[PageDown]=[6~

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

export PAGER=most
export EDITOR=vim
export PATH=$PATH":/home/kanak/.bin/"

#source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
