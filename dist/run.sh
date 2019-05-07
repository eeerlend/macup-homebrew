#!/bin/sh

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
for ((i=0; i<${#MACUP_HOMEBREW_PACKAGES[@]}; ++i)); do
	if brew ls --versions "${MACUP_HOMEBREW_PACKAGES[i]}" >/dev/null; then
		if (brew outdated | grep "${MACUP_HOMEBREW_PACKAGES[i]}" > /dev/null); then brew upgrade "${MACUP_HOMEBREW_PACKAGES[i]}"; else echo " ${MACUP_HOMEBREW_PACKAGES[i]} is already up to date"; fi
    else
		  report_from_package "${MACUP_HOMEBREW_PACKAGES[i]} being installed"
      HOMEBREW_NO_AUTO_UPDATE=1 brew install "${MACUP_HOMEBREW_PACKAGES[i]}"
    fi
done
