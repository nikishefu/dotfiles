#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source /usr/share/git/completion/git-prompt.sh

exitstatus() {
    if [[ $? == 0 ]]; then
        echo ''
    else
        echo "[$?] "
    fi
}

bind 'set show-all-if-ambiguous on'

export PATH="$HOME/Scripts:$HOME/.config/emacs/bin:$PATH"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias nv='nvim .'
alias tmux='TERM=xterm-256color tmux'
alias ssh='TERM=xterm-256color ssh'
alias newsboat='https_proxy="socks5://127.0.0.1:10808" newsboat'
alias proxy='https_proxy="socks5://127.0.0.1:10808"'
PS1='\[\e[38;5;39m\]$(exitstatus)\u\[\e[38;5;45m\]@\[\e[38;5;51m\]\h \[\e[38;5;195m\]\w$(__git_ps1) \[\033[0m\]\n\$ '
