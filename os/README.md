# Setting up a brand new shiny Mac

## Update the OS

Even though it's new, it's still worth checking if there are any updates.


## Install Xcode and Command Line Tools

1. Go to App Store and install Xcode
1. Open and accept the terms and conditions
1. Go to the Terminal and install Command Line Tools:

```sh
xcode-select --install
```


## Install Dotfiles (this repo)

Follow the instructions in the main [Readme](../README.md)


## Apply custom defaults

To apply the [custom macOS defaults](macos-defaults.sh), inside the `os` dir run:

```sh
./macos-defaults.sh
```


## Install Applications

To install frequently used [apps](install-apps.sh), inside the `os` dir run:

```sh
./install-apps.sh
```


## Generate SSH keys for GitHub

Follow [GitHub's official guide](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/)


## TODO

1. Sublime Text preferences
1. Sublime Text plugins

