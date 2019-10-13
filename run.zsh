#!/usr/bin/env zsh

emulate zsh -o extendedglob -o typesetsilent -o rcquotes

print -P "%F{160}Removing previous plugins and results…%f"

rm -rf **/(_zplug|_zgen|_zplugin)(DN) *.txt

print -P "%F{160}done%f"

print -P "\n%F{160}==========================%f"
print -P "%F{160}Running installation test…%f"
print -P "%F{160}==========================%f"

for i in zplug zgen zplugin*~*omz; do
    print -P "\n%F{154}=== 3 results for %F{140}$i%F{154}: ===%f"
    pushd $i
    ZDOTDIR=$PWD zsh -i -c exit |& grep '\[zshrc\]' | tee -a ../$i-inst.txt
    rm -rf _(zplug|zgen|zplugin)
    ZDOTDIR=$PWD zsh -i -c exit |& grep '\[zshrc\]' | tee -a ../$i-inst.txt
    rm -rf _(zplug|zgen|zplugin)
    ZDOTDIR=$PWD zsh -i -c exit |& grep '\[zshrc\]' | tee -a ../$i-inst.txt
    rm -rf _(zplug|zgen|zplugin)
    popd
done

print -P "\n%F{160}==========================%f"
print -P "%F{160}Running startup-time test…%f"
print -P "%F{160}==========================%f"

for i in zplug zgen zplugin*~(*omz|*txt); do
    print -P "\n%F{154}=== 10 results for %F{140}$i%F{154}: ===%f"
    pushd $i

    # Warmup
    repeat 20 {
        ZDOTDIR=$PWD zsh -i -c exit &>/dev/null
    }

    # The proper test
    repeat 10 {
        ZDOTDIR=$PWD zsh -i -c exit |& grep '\[zshrc\]' | tee -a ../$i.txt
    }

    popd
done
