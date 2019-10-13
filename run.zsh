#!/usr/bin/env zsh

emulate zsh

print -P "%F{160}Removing previous plugins…%f"

rm -rf **/(_zplug|_zgen|_zplugin)

print -P "%F{160}done%f\n"

print -P "%F{160}==========================%f"
print -P "%F{160}Running installation test…%f"
print -P "%F{160}==========================%f"

for i in zplug zgen zplugin*; do
    print -P "%F{154}=== Results for %F{130}$i%F{154}: ===%f"
    pushd $i
    repeat 10 {
        ZDOTDIR=$PWD zsh -i -c exit |& grep '\[zshrc\]'
    }
    popd
done

print -P "%F{160}==========================%f"
print -P "%F{160}Running startup-time test…%f"
print -P "%F{160}==========================%f"

for i in zplug zgen zplugin*; do
    print -P "%F{154}=== Results for %F{130}$i%F{154}: ===%f"
    pushd $i
    repeat 10 {
        ZDOTDIR=$PWD zsh -i -c exit |& grep '\[zshrc\]'
    }
    popd
done
