typeset -gA ZPLGM
ZPLGM[HOME_DIR]=$PWD/_zplugin
ZPFX=${ZPLGM[HOME_DIR]}/polaris

if [[ ! -d ${ZPLGM[HOME_DIR]}/bin ]]; then
    git clone --depth 1 https://github.com/zdharma-continuum/zinit "${ZPLGM[HOME_DIR]}/bin"
fi

# Start measuring time, in general with microsecond accuracy
typeset -F4 SECONDS=0

source "${ZPLGM[HOME_DIR]}/bin/zplugin.zsh"

# Ensure that zplugin is compiled
if [[ ! -f ${ZPLGM[BIN_DIR]}/zplugin.zsh.zwc ]]; then
    zplugin self-update
fi

# A.
setopt promptsubst

# B.
zplugin ice wait lucid
zplugin snippet OMZ::lib/git.zsh

# C.
zplugin ice wait atload"unalias grv" lucid
zplugin snippet OMZ::plugins/git/git.plugin.zsh

# D.
PS1="READY >" # provide a nice prompt till the theme loads
zplugin ice wait'!' lucid
zplugin snippet OMZ::themes/dstufft.zsh-theme

# E.
zplugin ice wait lucid
zplugin snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

# F.
zplugin ice wait as"completion" lucid
zplugin snippet OMZ::plugins/docker/_docker

# G.
zplugin ice wait atinit"zpcompinit" lucid
zplugin light zdharma/fast-syntax-highlighting

zplugin ice wait atload"_zsh_autosuggest_start" lucid
zplugin light zsh-users/zsh-autosuggestions

print "[zshrc] Zplugin block took ${(M)$(( SECONDS * 1000 ))#*.?} ms"
