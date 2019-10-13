# Start measuring time, in general with microsecond accuracy
typeset -F4 SECONDS=0

HOME=$ZDOTDIR

ZGEN_DIR=$HOME/_zgen

compdef() { :; }

if [[ ! -d $HOME/.zgen ]]; then
    git clone --depth 1 https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
fi

source "${HOME}/.zgen/zgen.zsh"

# if the init script doesn't exist
if ! zgen saved; then

    # specify plugins here
    # zgen oh-my-zsh

    # Assign each zsh session an unique ID, available in
    # ZUID_ID and also a codename (ZUID_CODENAME)
    zgen load zdharma/zsh-unique-id

    # Loaded mostly to stay in touch with the plugin (for the users)
    # and for the themes 2 & 3 (lambda-mod-zsh-theme & lambda-gitster)
    zgen oh-my-zsh lib/git.zsh

    # Loaded mostly to stay in touch with the plugin (for the users)
    zgen oh-my-zsh plugins/git

    # On OSX, you might need to install coreutils from homebrew and use the
    # g-prefix – gsed, gdircolors
    #zgen load trapd00r/LS_COLORS
    zgen load zdharma/null null.plugin.zsh empty-plugin.zsh

    # Another light of the same plugin, to add zc-bg-notify to PATH
    #zgen load zdharma/zconvey
    zgen load zdharma/null null.plugin.zsh empty-plugin.zsh-2

    # fzy
    #zgen load jhawthorn/fzy
    zgen load zdharma/null null.plugin.zsh empty-plugin.zsh-3

    # fzf, for fzf-marks
    #zgen load junegunn/fzf-bin
    zgen load zdharma/null null.plugin.zsh empty-plugin.zsh-4

    # fzf-marks, at slot 0, for quick Ctrl-G accessibility
    zgen load urbainvaes/fzf-marks

    # zsh-autopair
    zgen load hlissner/zsh-autopair zsh-autopair.plugin.zsh

    # zsh-editing-workbench & zsh-navigation-tools
    zgen load psprint/zsh-editing-workbench
    zgen load psprint/zsh-navigation-tools   # for n-history

    # zdharma/history-search-multi-word
    zgen load zdharma/history-search-multi-word

    # Theme no. 4 – pure
    zgen load geometry-zsh/geometry

    # ZUI and Crasis
    zgen load zdharma/zui

    # Gitignore plugin – commands gii and gi
    zgen load voronkovich/gitignore.plugin.zsh

    # Autosuggestions & fast-syntax-highloading
    zgen load zsh-users/zsh-autosuggestions
    #zplugin ice lucid atinit"ZPLGM[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay"
    #zgen load zdharma/fast-syntax-highlighting

    # ogham/exa, replacement for ls
    #zgen load ogham/exa
    zgen load zdharma/null null.plugin.zsh empty-plugin.zsh-5

    # vramsteg
    #zgen load psprint/vramsteg-zsh
    zgen load zdharma/null null.plugin.zsh empty-plugin.zsh-6

    # revolver
    #zgen load psprint/revolver
    zgen load zdharma/null null.plugin.zsh empty-plugin.zsh-7

    # zunit
    # zgen load psprint/zunit
    zgen load zdharma/null null.plugin.zsh empty-plugin.zsh-8

    # declare-zshrc
    zgen load zdharma/declare-zshrc

    # zsh-diff-so-fancy
    zgen load zdharma/zsh-diff-so-fancy

    # git-now
    #zgen load iwata/git-now
    zgen load zdharma/null null.plugin.zsh empty-plugin.zsh-9

    # git-extras
    # zgen load tj/git-extras
    zgen load zdharma/null null.plugin.zsh empty-plugin.zsh-10

    # git-cal
    #zgen load k4rthik/git-cal
    zgen load zdharma/null null.plugin.zsh empty-plugin.zsh-11

    # git-url
    #zgen load zdharma/git-url
    zgen load zdharma/null null.plugin.zsh empty-plugin.zsh-12

    # git-recall
    #zgen load Fakerr/git-recall
    zgen load zdharma/null null.plugin.zsh empty-plugin.zsh-13

    # git-quick-stats
    #zgen load arzzen/git-quick-stats.git
    zgen load zdharma/null null.plugin.zsh empty-plugin.zsh-14

    # generate the init script from plugins above
    zgen save
fi

print "[zshrc] Zgen block took ${(M)$(( SECONDS * 1000 ))#*.?} ms"
