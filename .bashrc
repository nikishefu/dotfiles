#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source /usr/share/git/completion/git-prompt.sh
source ~/completion.bash

exitstatus() {
    if [[ $? == 0 ]]; then
        echo ''
    else
        echo "[$?] "
    fi
}

bind 'set show-all-if-ambiguous on'

export PATH="$HOME/Scripts:$HOME/.config/emacs/bin:$PATH"
export PATH=$PATH:$(go env GOPATH)/bin

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias nv='nvim'
alias sv='EDITOR=nvim sudoedit'
alias e='yazi'
alias tmux='TERM=xterm-256color tmux'
alias ssh='TERM=xterm-256color ssh'
alias proxy='https_proxy="socks5://127.0.0.1:10808"'
alias kubectl='minikube kubectl --'
PS1='\[\e[38;5;16m\]$(exitstatus)\u\[\e[38;5;17m\]@\[\e[38;5;16m\]\h \[\e[38;5;195m\]\w$(__git_ps1) \[\033[0m\]\n\$ '

# The next line updates PATH for CLI.
if [ -f '/home/nikita/yandex-cloud/path.bash.inc' ]; then source '/home/nikita/yandex-cloud/path.bash.inc'; fi

# The next line enables shell command completion for yc.
if [ -f '/home/nikita/yandex-cloud/completion.bash.inc' ]; then source '/home/nikita/yandex-cloud/completion.bash.inc'; fi


if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init - bash)"
fi

# Created by `pipx` on 2025-12-01 09:47:43
export PATH="$PATH:/home/nikita/.local/bin"
eval "$(register-python-argcomplete pipx)"


alias notes='cd ~/Notes && zk edit -i'
