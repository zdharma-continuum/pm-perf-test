# Performance test of some of the Zsh plugin managers

To run the test, execute:

```zsh
./run.zsh
```

However, there are problems with `zplug` when running the test this way – the test hangs with a message:

```
zsh: suspended (tty input)  ./run.zsh
```

So an invocation of `fg` is required. To address this, run the test script as a function:

```zsh
fpath+=( $PWD )
autoload run.zsh
run.zsh
```

## Drawing the results

To generate a graph of the average load times:

First, install dependencies:

```zsh
python3 -m pip install matplotlib
```

Then,

```zsh
python3 plot.py
```

## Details of the test

The test loads the following 28 plugins:

```
arzzen/git-quick-stats.git
fakerr/git-recall
geometry-zsh/geometry
hlissner/zsh-autopair
iwata/git-now
jhawthorn/fzy
junegunn/fzf-bin
k4rthik/git-cal
ogham/exa
ohmyzsh / lib/git.zsh
ohmyzsh / plugins/git/git.plugin.zsh
tj/git-extras
trapd00r/ls_colors
urbainvaes/fzf-marks
voronkovich/gitignore.plugin.zsh
zdharma-continuum/declare-zshrc
zdharma-continuum/git-url
zdharma-continuum/history-search-multi-word
zdharma-continuum/revolver
zdharma-continuum/vramsteg-zsh
zdharma-continuum/zconvey
zdharma-continuum/zsh-diff-so-fancy
zdharma-continuum/zsh-editing-workbench
zdharma-continuum/zsh-navigation-tools
zdharma-continuum/zsh-unique-id
zdharma-continuum/zui
zdharma-continuum/zunit
zsh-users/zsh-autosuggestions
```

Some of the plugins are relatively regular `Makefile`-based projects, like `arzzen/git-quick-stats.git`. The
`atclone''`, `make''`, ice modifiers of Zinit and the `hook-build` tag of Zplug allow to install and use them. However
they're problematic with `zgen`, which doesn't have such hooks. For it, instead an empty plugin
[zdharma/null](https://github.com/zdharma/null) is being loaded in a following way:

```zsh
# git-recall
zgen load zdharma-continuum/null null.plugin.zsh empty-plugin.zsh-13
```

```zsh
# git-quick-stats
zgen load zdharma-continuum/null null.plugin.zsh empty-plugin.zsh-14
```

the `empty-plugin.zsh-14`, etc. is a branch. The file `null.plugin.zsh` contains only 3 instructions:

```zsh
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"
true
```

This way, a little balance is introduced into the test and creates a good minimum for the comparison – to have `zgen`
only clone and load an almost empty plugin instead of setting up a `PATH` for a command-like plugin, especially because
of the way that `zgen` works – by storing plain `source` commands and not executing any code.

However, it puts `zgen` in a better position because it has to clone an almost empty repository and not a complete
project, so the installation-time test is biased. However, it's hard to address this without simplifying the test
because of limited `zgen` functionality. Also, `zgen` doesn't run the compilation (i.e. `make`) during the installation
of the plugins.

Zplug and Zinit tests are relatively identical
([zshrc](https://github.com/zdharma/pm-perf-test/blob/master/zplug/.zshrc) for Zplug,
[zshrc](https://github.com/zdharma/pm-perf-test/blob/master/zinit-load/.zshrc) for Zinit).

## Results

![Installation times](https://raw.githubusercontent.com/zdharma-continuum/pm-perf-test/master/plots/installation-times.png)

![Startup times](https://raw.githubusercontent.com/zdharma-continuum/pm-perf-test/master/plots/startup-times.png)

## Result comments

The three different Zinit results need explaining:

1. Zinit light – plugins are being loaded without tracking, i.e., cannot be unloaded, and their reports are empty.
1. Zinit load – plugins are being loaded with tracking, i.e., are available for unloading, and their report data is
   gathered (available through `zinit report {plugin-name}` command).
1. Zinit (Turbo) load – plugins are loaded with tracking **and in Turbo mode** – i.e., in the background & after prompt
   – the shell is instantly ready to use.

<!-- vim:set ft=markdown tw=80 autoindent: -->
