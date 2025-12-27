#!/bin/bash

# Dotfiles Installation Script
# This script sets up zsh and oh-my-zsh configuration

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper functions
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_warning "This script is designed for macOS. Some features might not work on other systems."
fi

print_info "Starting dotfiles installation..."

# Create backup directory
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
print_info "Backup directory created: $BACKUP_DIR"

# Backup existing configurations
backup_file() {
    local file="$1"
    if [ -f "$HOME/$file" ] || [ -L "$HOME/$file" ]; then
        print_info "Backing up $file"
        cp -L "$HOME/$file" "$BACKUP_DIR/" 2>/dev/null || true
    fi
}

backup_file ".zshrc"
backup_file ".p10k.zsh"
backup_file ".fzf.zsh"
backup_file ".zshenv"

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    print_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    print_info "Homebrew already installed"
fi

# Install dependencies via Homebrew
print_info "Installing dependencies..."
brew install zsh git fzf thefuck

# Install oh-my-zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_info "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    print_info "oh-my-zsh already installed"
fi

# Install Powerlevel10k theme
P10K_DIR="$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
if [ ! -d "$P10K_DIR" ]; then
    print_info "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
else
    print_info "Powerlevel10k already installed"
fi

# Install zsh plugins
PLUGIN_DIR="$HOME/.oh-my-zsh/custom/plugins"

# zsh-autosuggestions
if [ ! -d "$PLUGIN_DIR/zsh-autosuggestions" ]; then
    print_info "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGIN_DIR/zsh-autosuggestions"
else
    print_info "zsh-autosuggestions already installed"
fi

# zsh-syntax-highlighting
if [ ! -d "$PLUGIN_DIR/zsh-syntax-highlighting" ]; then
    print_info "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGIN_DIR/zsh-syntax-highlighting"
else
    print_info "zsh-syntax-highlighting already installed"
fi

# Copy configuration files
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_info "Copying configuration files..."
cp "$DOTFILES_DIR/zsh/.zshrc" "$HOME/"
cp "$DOTFILES_DIR/zsh/.p10k.zsh" "$HOME/"
cp "$DOTFILES_DIR/zsh/.fzf.zsh" "$HOME/"
cp "$DOTFILES_DIR/zsh/.zshenv" "$HOME/"

# Copy oh-my-zsh custom configurations
if [ -d "$DOTFILES_DIR/oh-my-zsh/custom" ]; then
    print_info "Copying oh-my-zsh custom configurations..."
    cp -r "$DOTFILES_DIR/oh-my-zsh/custom/"* "$HOME/.oh-my-zsh/custom/"
fi

# Setup fzf
print_info "Setting up fzf..."
$(brew --prefix)/opt/fzf/install --all

# Change default shell to zsh if not already
if [ "$SHELL" != "$(which zsh)" ]; then
    print_info "Changing default shell to zsh..."
    chsh -s "$(which zsh)"
fi

print_info "Installation completed!"
print_warning "Please edit ~/.zshrc to add your personal configuration:"
echo "  - API keys (OPENAI_API_KEY, etc.)"
echo "  - Firebase credentials path"
echo "  - SSH aliases"
echo "  - Any other personal settings"
print_info "Restart your terminal or run 'source ~/.zshrc' to apply changes"
print_info "Run 'p10k configure' to customize your Powerlevel10k prompt"