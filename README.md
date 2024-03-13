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

### Ubuntu

If neovim complains that "lazy.vim requires neovim version >= 0.8.0", you must
execute following commands (without leading "$"):

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

