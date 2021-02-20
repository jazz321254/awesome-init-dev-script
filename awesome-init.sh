#!/usr/bin/env bash

# ============================================
# 1. Setting OSX
#    a. Install Xcode 
#    b. Set OS defaults
# 2. Initial developer workspace
#    a. Install Homebrew
#    b. Install basic command-line tools
#    c. Install some fonts
#    d. Install some Applications
# 3. Install developer tools
#    a. Inatall language framework
#       * NVM (Node)
#       * Dotnet Core
#    b. Install IDE
#       * VS Code
#       * Neovim
#    c. Install Other dev tools
#    d. Install container tools 
# ============================================

# Ask for the administrator password upfront
sudo -v

while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "------------------------------"
echo "Installing Xcode Command Line Tools."
# Install Xcode command line tools
xcode-select --install

# Set OS Defaults
echo "Setting OS Defaults..."
## Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

## Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

## Disable smart quotes as they're annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

## Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

## Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15

## Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

## Setting mouse classic scrolling
defaults write -g com.apple.swipescrolldirection -bool FALSE

## Never sleep
systemsetup -setcomputersleep Never

echo "------------------------------"
echo "Initializing Development Workspace"

export HOMEBREW_NO_AUTO_UPDATE=1

# Check for Homebrew, Install if we don't have it
if test ! $(which brew); then
echo "Installing Homebrew..."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
# Make sure we're using the latest Homebrew.
brew update

# Install basic tools
brew install archey
brew install wget
brew install httpie
brew install htop
brew install python
brew install emojify

# Install fonts
brew tap homebrew/cask-fonts 
brew install --cask font-hack-nerd-font

# Install Desktop Applications
if [ ! -d "/Applications/iTerm.app" ]; then
	echo "Install iTerm2"
	brew install --cask --appdir="/Applications" iterm2
fi
if [ ! -d "/Applications/Google Chrome.app" ]; then
	echo "Installing Google Chrome..."
	brew install --cask --appdir="/Applications" google-chrome
fi
if [ ! -d "/Applications/Firefox.app" ]; then
	echo "Installing firefox"
	brew install --cask --appdir="/Applications" firefox
fi
if [ ! -d "/Applications/Chromium.app" ]; then
	echo "Installing chromium" 
	brew install --cask --appdir="/Applications" chromium
fi

# Install Oh My Zsh
echo "Installing Oh My Zsh (Z shell)..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
## use p10k
rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
## zsh -i -c "p10k configure"
sed -i '' 's/^\(ZSH_THEME=\).*$/\1\"powerlevel10k\/powerlevel10k\"/' ~/.zshrc 
## Open iterm2 profile

echo "------------------------------"
echo "Initializing Devlopment Tools"

# Install Node
INSTALL_NODE_VER=14
INSTALL_NVM_VER=0.37.2

touch ~/.zshrc 
touch ~/.bash_profile 
rm -rf ~/.nvm
ps -p $$
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v$INSTALL_NVM_VER/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
nvm install $INSTALL_NODE_VER
nvm alias default $INSTALL_NODE_VER
nvm use default
# Install Yarn
rm -rf ~/.yarn
curl -o- -L https://yarnpkg.com/install.sh | bash
export PATH="$HOME/.yarn/bin:$PATH"
yarn config set prefix ~/.yarn -g
nvm --version
node --version
npm --version
yarn --version
nvm ls
nvm cache clear
# setting export
cat << EOF >> ~/.zshrc
export NVM_DIR="\$([ -z "\${XDG_CONFIG_HOME-}" ] && printf %s "\${HOME}/.nvm" || printf %s "\${XDG_CONFIG_HOME}/nvm")"
[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"
EOF

# Install Dotnet Core
curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel LTS # or use --version to specific version to install. ex: 3.0.100
rm /usr/local/bin/dotnet 2> /dev/null
sudo ln -s $HOME/.dotnet/dotnet /usr/local/bin/dotnet
dotnet --info

# Install IDE
echo "Installing VSCode..."
brew install --cask visual-studio-code
cat << EOF >> ~/.zshrc
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
EOF
## vue extension
code --install-extension dbaeumer.vscode-eslint
code --install-extension octref.vetur
## dotnet extension 
code --install-extension ms-dotnettools.csharp
code --install-extension formulahendry.dotnet-test-explorer
## other extension
code --install-extension mhutchie.git-graph
code --install-extension ryanluker.vscode-coverage-gutters 
## import setting.json
cp ./config/vscode/settings.json ~/Library/Application\ Support/Code/User

# Install Nvim
echo "Installing Nvim..."
brew install neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
## setting config
mkdir -p ~/.config/nvim/colors
cp ./config/nvim/init.vim ~/.config/nvim
cd ~/.config/nvim/colors && { curl -LJO https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim ; cd -; }
echo "install nvim finish, restart nvim and type PlugInstall to install plugin" 

# Install tumx
brew install tmux

# Install Docker adn vagrant
brew install --cask docker
brew install --cask virtualbox
brew install --cask vagrant
brew install --cask vagrant-manager

# Install k8s
brew install kubectl

# Setting shurtcut

# Setting alias
# chsh -s $(which zsh)

echo ":tada: Development Environment Ready" | emojify
echo ":heart: Be sure to checkout the README for more details on this script" | emojify
echo ":smile: Restart your computer to ensure all updates take effect" | emojify
