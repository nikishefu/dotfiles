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
alias sv='EDITOR=nvim sudoedit'
alias e='yazi'
alias tmux='TERM=xterm-256color tmux'
alias ssh='TERM=xterm-256color ssh'
alias proxy='http_proxy="http://127.0.0.1:10809"'
alias claude='proxy claude'
PS1='\[\e[38;5;255m\]$(exitstatus)\[\e[38;5;159m\]\u\[\e[38;5;245m\]@\[\e[38;5;117m\]\h \[\e[38;5;153m\]\w\[\e[38;5;177m\]$(__git_ps1 " (%s)")\[\e[0m\] \[\e[38;5;80m\]\t\[\e[0m\]\n\[\e[38;5;80m\]\$ \[\e[0m\]'

# The next line updates PATH for CLI.
if [ -f '/home/nikita/yandex-cloud/path.bash.inc' ]; then source '/home/nikita/yandex-cloud/path.bash.inc'; fi

# The next line enables shell command completion for yc.
if [ -f '/home/nikita/yandex-cloud/completion.bash.inc' ]; then source '/home/nikita/yandex-cloud/completion.bash.inc'; fi


if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init - bash)"
fi

alias notes='cd ~/Notes && zk edit -i'
export CMAKE_BUILD_PARALLEL_LEVEL=$(nproc)

nv() { if [[ -v TMUX ]]; then tmux new-window nvim "$@"; else tmux new-session nvim "$@"; fi; }
