# dotfiles

Shell, terminal emulator, editor, and OSX setup.

![iTerm2](img/terminal.png)
![vscode](img/vscode.png)

# Installation

### Backup your Mac

`bootstrap.sh` installs Homebrew, various terminal and binary applications, and overrides a number of defaults on Mac OSX.

### Clone & run `bootstrap.sh`

```bash
xcode-select --install # Only required if you haven't used Git before
cd ~
git clone git@github.com:kevinschaich/dotfiles.git 
chmod u+x ~/dotfiles/bootstrap.sh 
~/dotfiles/bootstrap.sh
```

As one command:

```bash
xcode-select --install && cd && git clone git@github.com:kevinschaich/dotfiles.git && chmod u+x ~/dotfiles/bootstrap.sh && ~/dotfiles/bootstrap.sh
```

## License

MIT © [Kevin Schaich](https://kevinschaich.io)
