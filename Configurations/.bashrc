# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH
export EDITOR=vim

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

#Aliases

alias calc='_calc(){ echo | awk "{print $*}"; }; _calc '
alias oleroot='ssh root@localhost -p12345'
alias client='ssh StanislavStarodub@localhost -p12345'
alias server='ssh StanislavStarodub@localhost -p12346'
alias ubuntu='ssh student@localhost -p12347'
alias cls='sudo dnf autoremove && sudo dnf clean all'
alias shut='sudo poweroff'
alias upd='sudo dnf update -y'
alias lAh='ls -lAht --color=auto'
alias ltr='ls -lhtr --color=auto'
alias di='docker image'
alias d='docker'
alias kvmdown='sudo rmmod kvm-intel'
alias pbcopy="xclip -selection c"
alias pbpaste="xclip -selection c -o"
alias tage='/home/sss/SCRIPTS/tagdoc/tagdoc.sh edit'
alias tagl='/home/sss/SCRIPTS/tagdoc/tagdoc.sh list'
alias serve='python -m RangeHTTPServer 3000'
alias vblong='VBoxManage list vms --long'

PS1='\[\e[1;33m\]\t \[\e[1;32m\]\u@\h\[\e[1;37m\]:\w\n\[\e[1;31m\]\$\[\e[1;37m\]>\[\e[0m\]'
#PS1='\u@\h: \w \$>'
if [ -f /etc/profile.d/bash_completion.sh ]; then
    . /etc/profile.d/bash_completion.sh
fi
