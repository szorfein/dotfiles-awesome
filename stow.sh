#!/usr/bin/env sh

set -o errexit

DEBUG=false

# Search dotfiles
[ -d "$HOME/.dotfiles" ] && DOTFILES="$HOME/.dotfiles"

if [ -z "$DOTFILES" ]; then
    [ -z "$DOTFILES_DIR"] && dagger "Dotfiles directory no found, use export DOTFILES_DIR=\"your_path\""
    DOTFILES="$DOTFILES_DIR"
fi

dagger() {
    echo "$1"
    exit 1
}

del_stow() {
    [ $DEBUG = true ] && echo "Removing $2 from $1..."
    stow -d "$1" -D "$2" -t "$HOME"
}

add_stow() {
    echo "Adding $2 from $1..."
    stow -d "$1" "$2" -t "$HOME"
}

# from https://github.com/dylanaraps/pure-sh-bible
basename() {
    dir=${1%${1##*[!/]}}
    dir=${dir##*/}
    dir=${dir%"$2"}
    printf '%s\n' "${dir:-/}"
}

purge_stow() {
    echo "Uninstalling all dots from $DOTFILES..."

    for dir in .x awesome mpd ncmpcpp tmux zsh vim; do
        [ -d "$DOTFILES/$dir" ] || continue
        del_stow "$DOTFILES" "$dir"
    done

    # awesome material 3
    THEMES_DIR="$DOTFILES/awesome-themes"
    for dir in $THEMES_DIR/*; do
        [ -d "$dir" ] || continue
        theme_dir=$(basename "$dir")
        del_stow "$THEMES_DIR" "$theme_dir"
    done
}

usage() {
    echo "Arguments:"
    printf "\t%s\t\t\t\t%s\n" "--purge" "Remove all older stow links, use it after each updates as first argument"
    printf "\t%s\t%s\n" "-a3 | --awesome theme-name" "Add awesome-wm with a theme-name ('lines', 'connected', 'miami', 'morpho', 'anonymous')"
    printf "\t%s\t\t\t%s\n" "-n | --ncmpcpp" "Add dots for ncmpcpp"
    printf "\t%s\t\t\t%s\n" "-t | --tmux" "Add dots for tmux"
    printf "\t%s\t\t\t%s\n" "-z | --zsh" "Add dots for zsh"
    printf "\t%s\t\t\t%s\n" "-v | --vim" "Add dots for Vim"
    printf "\nExamples:\n"
    echo 'stow.sh --purge --tmux --vim --awesome lines'
    echo 'stow.sh -p -t -nv -a2 lines'
}

# Arguments
while [ "$#" -gt 0 ]; do
    case "$1" in
    -n | --ncmpcpp)
        add_stow "$DOTFILES" "ncmpcpp"
        shift
        ;;
    -a2 | --awesome)
        mkdir -p "$HOME/.config/awesome/theme"
        mkdir -p "$HOME/.tmux"
        mkdir -p "$HOME/.vim"
        add_stow "$DOTFILES" ".x"
        add_stow "$DOTFILES" "awesome"
        add_stow "$DOTFILES/awesome-themes" "$2"
        shift
        shift
        ;;
    -t | --tmux)
        add_stow "$DOTFILES" "tmux"
        shift
        ;;
    -z | --zsh)
        # Present on Voidlinux
        [ -f ~/.inputrc ] && rm ~/.inputrc
        mkdir -p "$HOME/bin"
        add_stow "$DOTFILES" "zsh"
        shift
        ;;
    -v | --vim)
        mkdir -p "$HOME/.vim"
        add_stow "$DOTFILES" "vim"
        shift
        ;;
    -p | --purge)
        purge_stow
        shift
        ;;
    --debug)
        DEBUG=true
        shift
        ;;
    -h | --help)
        usage
        exit 0
        ;;
    *)
        printf "\\n%s\\n" "$0: Invalid option '$1'"
        exit 1
        ;;
    esac
done
