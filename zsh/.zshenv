MY_PATH="$HOME/bin"

# https://wiki.archlinux.org/title/Ruby#Setup
if hash ruby 2>/dev/null ; then
  export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
  MY_PATH="$MY_PATH:$GEM_HOME/bin"
fi

export PATH="$PATH:$MY_PATH"

# Default terminal
export TERMINAL=xst
export TERM=xst-256color

# XDG
export XDG_CONFIG_HOME="$HOME"/.config

# Locale
export LANG=en_US.UTF-8

# Directory to encrypt password with vim-gpg
export PASSWD=~/.passwords

# Editor
export EDITOR=vim
export SUDO_EDITOR=vim
export VISUAL=vim

# History
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

# MPD music dir
export MPD_MUSIC_DIR="$HOME/musics"
# export MPD_PORT="6600"

# Path to your oh-my-zsh installation.
export ZSH="$HOME"/.oh-my-zsh
