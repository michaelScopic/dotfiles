#            _        __                      _    _                    
#  ____ ___ | |__    / _| _   _  _ __    ___ | |_ (_)  ___   _ __   ___ 
# |_  // __|| '_ \  | |_ | | | || '_ \  / __|| __|| | / _ \ | '_ \ / __|
#  / / \__ \| | | | |  _|| |_| || | | || (__ | |_ | || (_) || | | |\__ \
# /___||___/|_| |_| |_|   \__,_||_| |_| \___| \__||_| \___/ |_| |_||___/
#
### Written by: michaelScopic (https://github.com/michaelScopic)


## Automatically run 'ls' after you cd into a dir
cd() {
    builtin cd "$@" &&
        command exa --icons --group-directories-first -hFg
}

## Recompile completion and then reload zsh
src() {
    toload -U zrecompile
    rm -rf "$compfile"*
    compinit -u -d "$compfile"
    zrecompile -p "$compfile"
    exec zsh
}

## Extract different archive formats
extract() {
    if [ -f $1 ]; then
        case $1 in
        *.tar.bz2) tar xvjf $1 ;;
        *.tar.gz) tar xvzf $1 ;;
        *.tar.xz) tar xf $1 ;;
        *.bz2) bunzip2 $1 ;;
        *.rar) unrar x $1 ;;
        *.gz) gunzip $1 ;;
        *.tar) tar xvf $1 ;;
        *.tbz2) tar xvjf $1 ;;
        *.tgz) tar xvzf $1 ;;
        *.zip) unzip $1 ;;
        *.Z) uncompress $1 ;;
        *.7z) 7z x $1 ;;
        *) echo "Not sure how to decompress this: '$1'" ;;
        esac
    else
        echo "'$1': Not a valid file."
    fi
}
