#    ▒███████▒  ██████  ██░ ██  ██▀███   ▄████▄
#    ▒ ▒ ▒ ▄▀░▒██    ▒ ▓██░ ██▒▓██ ▒ ██▒▒██▀ ▀█
#    ░ ▒ ▄▀▒░ ░ ▓██▄   ▒██▀▀██░▓██ ░▄█ ▒▒▓█    ▄
#      ▄▀▒   ░  ▒   ██▒░▓█ ░██ ▒██▀▀█▄  ▒▓▓▄ ▄██▒
#    ▒███████▒▒██████▒▒░▓█▒░██▓░██▓ ▒██▒▒ ▓███▀ ░
#    ░▒▒ ▓░▒░▒▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒░ ▒▓ ░▒▓░░ ░▒ ▒  ░
#    ░░▒ ▒ ░ ▒░ ░▒  ░ ░ ▒ ░▒░ ░  ░▒ ░ ▒░  ░  ▒
#    ░ ░ ░ ░ ░░  ░  ░   ░  ░░ ░  ░░   ░ ░
#      ░ ░          ░   ░  ░  ░   ░     ░ ░
#    ░                                  ░


# Plugin list in ~/.oh-my-zsh/plugins
# gpg-agent and keychain works together
plugins=(starship gpg-agent keychain zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search)

# Disable oh-my-zsh update (before load ohmyzsh)
# https://github.com/ohmyzsh/ohmyzsh#getting-updates
zstyle ':omz:update' mode disabled

# Keychain
zstyle ':omz:plugins:keychain' agents gpg
#zstyle :omz:plugins:keychain identities id_ed25519 id_github 2C5879C2
zstyle :omz:plugins:keychain options --quiet

source $ZSH/oh-my-zsh.sh

[ -f ~/.zprofile ] && source ~/.zprofile
[ -f ~/.zshenv ] && source ~/.zshenv

# Load .aliases.zsh
if [ -f $HOME/.aliases.zsh ] ; then
    source $HOME/.aliases.zsh
fi

# Load .zshenv
if [ -f $HOME/.zshenv ] ; then
    source $HOME/.zshenv
fi

# Bindkey fr
#bindkey "\e[2~"  yank
#bindkey "\e[3~"  delete-char
#bindkey "\e[1~"  beginning-of-line
#bindkey "\e[4~"  end-of-line
#bindkey "\e[5~"  up-line-or-history
#bindkey "\e[6~"  down-line-or-history

#unset GREP_OPTIONS
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || \
    eval "$(dircolors -b)"

# man page with less
man() {
    LESS_TERMCAP_mb=$'\e[0;31m' \
        LESS_TERMCAP_md=$'\e[01;35m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_so=$'\e[01;31;31m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[0;36m' \
        command man "$@"
}

