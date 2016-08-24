# DOTFILES

## Introduction


## Installation
1. Fork this repository
2. Clone to your machine
3. Run install.sh
    1. It will prompt you for the basic Git info, unless specified
    2. Custom Git info should be saved in ~/.gitconfig.local
4. Customise ~/bash.local as needed


## Re-Install
To re-install the new Git editor config, need to delete the `./git/gitconfig.local` file and run the installer `./install.sh`


### Additional Info
For the machines to use Sublime as the Git editor (probably only local machines, not servers), you'll need to symlink `subl` into `/usr/local/bin/` via

```
cd /usr/local/bin
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl
```


## Editing



### TODO:
1. OSX defaults
2. Backup - see below


### TODO: git

1. pretty diff (@paulirish) + uncomment in gitconfig


### TODO: shell


### TODO: Aliases/Functions

1. z - github.com/rupa/z
2. Software updates ala https://github.com/alrra/dotfiles/blob/master/shell/bash_aliases or https://github.com/mathiasbynens/dotfiles/blob/master/.aliases


### Syntax highlighting for these files

If you edit this stuff, install [Dotfiles Syntax Highlighting](https://github.com/mattbanks/dotfiles-syntax-highlighting-st2) via [Package Control](http://wbond.net/sublime_packages/package_control)


## Inspiration

https://github.com/paulirish/dotfiles
https://github.com/mathiasbynens/dotfiles/
https://github.com/alrra/dotfiles/
https://github.com/necolas/dotfiles
https://github.com/holman/dotfiles


## Interesting

http://nicolasgallagher.com/mac-osx-bootable-backup-drive-with-rsync/
