# DOTFILES

## Introduction
These are my personal dotfiles, [inspired by some awesome people](#inspiration) - use at your own risk.

## Installation
1. Fork this repository, review and remove any unwanted parts.
1. Clone to your machine, for example into `~/dotfiles`
1. Run `./install.sh`
    1. It will prompt you for the basic Git info, unless specified previously
    1. To modify this information, edit `~/.gitconfig.local`

    1. You will be prompted to back up any existing dotfiles that will be overwritten. ⚠️ I highly recommend you do this the first time you run the installer to back up the system default dotfiles, otherwise you'll have a hard time reverting back to defaults ⚠️
1. Customise `~/.bash.local` (`shell/bash.local`) for your personal preferences - sample file can be found in `shell/bash.local-sample`


## Re-Install
To re-install simply run `./install.sh` again.

To re-install and update the Git editor config, you will need to delete the `git/gitconfig.local` file and run the installer `./install.sh`


### Additional Info
For the machines to use Sublime as the Git editor (probably only local machines, not servers), you'll need to symlink `subl` into `/usr/local/bin/` via

```
cd /usr/local/bin
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl
```


## Editing

### Syntax highlighting for these files

If you edit this stuff, install [Dotfiles Syntax Highlighting](https://github.com/mattbanks/dotfiles-syntax-highlighting-st2) via [Package Control](https://packagecontrol.io)


## Inspiration

https://github.com/paulirish/dotfiles

https://github.com/mathiasbynens/dotfiles/

https://github.com/alrra/dotfiles/

https://github.com/necolas/dotfiles

https://github.com/holman/dotfiles

