# macup-homebrew

A [macup](https://github.com/eeerlend/macup) module that installs Homebrew on your mac.

## Installation
Run the following command to add it to your repo

```bash
npm install eeerlend/macup-homebrew --save
```

## Configuration
Add your own packages to be installed in the macup configuration file like this...

```bash
macup_homebrew_packages+=(
  git
  zsh
)
```
