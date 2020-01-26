typeset -gA ZPLGM
ZPLGM[HOME_DIR]=$PWD/_zplugin
ZPFX=${ZPLGM[HOME_DIR]}/polaris

if [[ ! -d ${ZPLGM[HOME_DIR]}/bin ]]; then
    git clone --depth 1 https://github.com/zdharma/zplugin "${ZPLGM[HOME_DIR]}/bin"
fi

# Start measuring time, in general with microsecond accuracy
typeset -F4 SECONDS=0

source "${ZPLGM[HOME_DIR]}/bin/zplugin.zsh"

# Ensure that zplugin is compiled
if [[ ! -f ${ZPLGM[BIN_DIR]}/zplugin.zsh.zwc ]]; then
    zplugin self-update
fi

# Assign each zsh session an unique ID, available in
# ZUID_ID and also a codename (ZUID_CODENAME)
zplugin light zdharma/zsh-unique-id

# Loaded mostly to stay in touch with the plugin (for the users)
# and for the themes 2 & 3 (lambda-mod-zsh-theme & lambda-gitster)
zplugin snippet OMZ::lib/git.zsh

# Loaded mostly to stay in touch with the plugin (for the users)
zplugin ice atload$'unalias grv g 2>/dev/null'
zplugin snippet OMZ::plugins/git/git.plugin.zsh

# On OSX, you might need to install coreutils from homebrew and use the
# g-prefix – gsed, gdircolors
zplugin ice \
    atclone"local PFX=${${(M)OSTYPE:#*darwin*}:+g}
            git reset --hard; \${PFX}sed -i \
            '/DIR/c\DIR                   38;5;63;1' LS_COLORS; \
            \${PFX}dircolors -b LS_COLORS > c.zsh" \
            atpull'%atclone' pick"c.zsh" nocompile'!' \
            atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zplugin light trapd00r/LS_COLORS

# Another light of the same plugin, to add zc-bg-notify to PATH
zplugin ice silent as"program" id-as"zconvey-cmd" pick"cmds/zc-bg-notify"
zplugin light zdharma/zconvey

# fzy
zplugin ice as"program" make"!PREFIX=$ZPFX install" \
    atclone"cp contrib/fzy-* $ZPFX/bin/" \
    pick"$ZPFX/bin/fzy*"
zplugin light jhawthorn/fzy

# fzf, for fzf-marks
zplugin ice from"gh-r" as"program"
zplugin light junegunn/fzf-bin

# fzf-marks, at slot 0, for quick Ctrl-G accessibility
zplugin light urbainvaes/fzf-marks

# zsh-autopair
zplugin light hlissner/zsh-autopair

# zredis together with some binding/tying
#zplugin ice atload'ztie -d db/redis -a 127.0.0.1:4815/5 -P $HOME/.zredisconf -zSL main rdhash'
#zplugin light zdharma/zredis

# zsh-editing-workbench & zsh-navigation-tools
zplugin light psprint/zsh-editing-workbench
zplugin light psprint/zsh-navigation-tools   # for n-history

# zdharma/history-search-multi-word
zplugin light zdharma/history-search-multi-word

# Theme no. 4 – pure
zplugin light geometry-zsh/geometry

# ZUI and Crasis
zplugin light zdharma/zui

# Gitignore plugin – commands gii and gi
zplugin light voronkovich/gitignore.plugin.zsh

# Autosuggestions
zplugin light zsh-users/zsh-autosuggestions

# ogham/exa, replacement for ls
zplugin ice from"gh-r" as"program" mv"exa* -> exa"
zplugin light ogham/exa

# vramsteg
zplugin ice as"program" pick"src/vramsteg" \
            atclone'cmake .' atpull'%atclone' make
zplugin light psprint/vramsteg-zsh

# revolver
zplugin ice as"program" pick"revolver"
zplugin light psprint/revolver

# zunit
zplugin ice as"program" pick"zunit" \
            atclone"./build.zsh" atpull"%atclone"
zplugin light psprint/zunit

# declare-zshrc
zplugin light zdharma/declare-zshrc

# zsh-diff-so-fancy
zplugin ice as"program" pick"bin/git-dsf"
zplugin light zdharma/zsh-diff-so-fancy

# git-now
zplugin ice as"program" pick"$ZPFX/bin/git-now" make"PREFIX=$ZPFX install"
zplugin light iwata/git-now

# git-extras
zplugin ice as"program" pick"$ZPFX/bin/git-alias" make"PREFIX=$ZPFX"
zplugin light tj/git-extras

# git-cal
zplugin ice as"program" atclone"perl Makefile.PL PREFIX=$ZPFX" \
    atpull'%atclone' make'install' pick"$ZPFX/bin/git-cal"
zplugin light k4rthik/git-cal

# git-url
zplugin ice as"program" pick"$ZPFX/bin/git-url" make"install PREFIX=$ZPFX GITURL_NO_CGITURL=1"
zplugin light zdharma/git-url

# git-recall
zplugin ice as"program" pick"git-recall"
zplugin light Fakerr/git-recall

# git-quick-stats
zplugin ice as"program" make"PREFIX=$ZPFX install" \
    pick"$ZPFX/bin/git-quick-stats" \
    atload"export _MENU_THEME=legacy"
zplugin light arzzen/git-quick-stats.git

autoload compinit
compinit

print "[zshrc] Zplugin block took ${(M)$(( SECONDS * 1000 ))#*.?} ms"
