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
git clone https://github.com/kevinschaich/dotfiles
chmod u+x ~/dotfiles/bootstrap.sh 
~/dotfiles/bootstrap.sh
```

> **Note:** If the `xcode-select --install` step fails, you may need to [download Xcode from the Mac App Store](https://apps.apple.com/us/app/xcode/id497799835?mt=12).

## License

MIT © [Kevin Schaich](https://kevinschaich.io)
