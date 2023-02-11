#### ==> ZSH FUNCTIONS <== ####

### Written by: michaelScopic (https://github.com/michaelScopic)

## Check if terminal is a psudo-terminal or a tty
if [ "$(tty >/dev/null)" == "/dev/pts/*" ]; then
    ## If terminal is a psudo-terminal/terminal emulator (/dev/pts/*), then use icons
    EXA_OPTIONS="--group-directories-first --icons -hFg"
else
    ## If terminal is a tty (/dev/tty*), then don't use icons
    EXA_OPTIONS="--group-directories-first -hFg"
fi

## Automatically run 'ls' after you cd into a dir
cd() {
    builtin cd "$@" &&
        command exa $EXA_OPTIONS
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
