# Link iCloud Drive to ~/sync
ln -s ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/sync ~/sync

# homebrew & command line tools
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Run these two commands in your terminal to add Homebrew to your PATH:
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/thomasbirbacher/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# fish shell
brew install fish
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish

# add homebrew to fish shell
eval (/opt/homebrew/bin/brew shellenv)
echo 'eval (/opt/homebrew/bin/brew shellenv)' >> ~/.config/fish/config.fish

# kitty
brew install --cask kitty

# backup: borg & borgmatic
brew install --cask macfuse
brew install borgbackup/tap/borgbackup-fuse
brew install pipx
pipx ensurepath
pipx install borgmatic

# reverse scroll direction only for mouse, not for trackpad
brew install --cask linearmouse

# FPGA development
brew install verilator
