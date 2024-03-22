# Lucifer Disciple's nvimrc

## Installation

```
[luciferdisciple@nexus nvimrc (master)]$ ./install.sh
[install.sh] File '/home/luciferdisciple/.config/nvim/init.lua' already exists. It will be backed up.
[install.sh] Do you want to proceed [Y/n]? y
[install.sh] Backing up init.vim at '/home/luciferdisciple/development/github.com/luciferDisciple/nvimrc/init.lua.bak1'
[install.sh] Created symoblic link '/home/luciferdisciple/.config/nvim/init.lua' to '/home/luciferdisciple/development/github.com/luciferDisciple/nvimrc/init.lua'
[install.sh] Success!
[luciferdisciple@nexus nvimrc (master)]$
```

## Troubleshooting

### 1. "lazy.vim requires neovim version..."

If you are on Ubuntu and neovim complains that "lazy.vim requires neovim
version >= 0.8.0", you must execute following commands (without leading "$"):

```
$ sudo add-apt-repository ppa:neovim-ppa/unstable
```

```
$ sudo apt update
```

```
$ sudo apt install neovim
```

This will install a newer version of neovim, then the one available in the
official Ubuntu repository.


### 2. "No C compiler found!"

If you are getting the following error message:

> No C compiler found! "cc", "gcc", "clang", "cl", "zig" are not executable   

Then you must ensure you have a compiler installed for the C programming
language. On Ubuntu just execute (without "$"):

```
$ sudo apt install build-essential
```
