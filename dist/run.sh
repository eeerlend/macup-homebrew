#!/bin/bash

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
	if brew ls --versions "${macup_homebrew_packages[i]}" >/dev/null; then
		if (brew outdated | grep "${macup_homebrew_packages[i]}" > /dev/null); then 
      brew upgrade "${macup_homebrew_packages[i]}"; 
    else 
      report_from_package " ${MACUP_HOMEBREW_PACKAGES[i]} is already up to date"; 
    fi
  else
    report_from_package "${macup_homebrew_packages[i]} being installed"
    HOMEBREW_NO_AUTO_UPDATE=1 brew install "${macup_homebrew_packages[i]}"
  fi
done
