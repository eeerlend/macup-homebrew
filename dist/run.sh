#!/bin/bash

function install_or_upgrade_brew_package {
  local package=$1
	if brew ls --versions "$package" >/dev/null; then
		if (brew outdated | grep "$package" > /dev/null); then 
      brew upgrade "$package"; 
    else 
      report_from_package " $package is already up to date"; 
    fi
  else
    report_from_package "$package being installed"
    HOMEBREW_NO_AUTO_UPDATE=1 brew install "$package"
  fi
}

# Check for Homebrew, install if we don't have it
if [ ! $(which brew) ]; then
	report_from_package "Homebrew is not installed, proceed with installation."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
	report_from_package "Homebrew already installed, now updating"
	brew update
fi

# Opt out of brew analytics
report_from_package "Turning off homebrew analytics"
brew analytics off

# Install Homebrew packages
# todo: check if array is declared up front!
# shellcheck disable=SC2154
for ((i=0; i<${#macup_homebrew_packages[@]}; ++i)); do
  install_or_upgrade_brew_package "${macup_homebrew_packages[i]}"
done
