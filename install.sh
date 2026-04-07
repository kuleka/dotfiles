#!/bin/bash
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info()    { echo -e "${GREEN}[INFO]${NC} $1"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ "$OSTYPE" != "darwin"* ]]; then
    echo -e "${RED}[ERROR]${NC} This script is designed for macOS only."
    exit 1
fi

info "Starting dotfiles installation..."

# ========== 备份 ==========
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

for f in .zshrc .fzf.zsh; do
    [ -f "$HOME/$f" ] && cp "$HOME/$f" "$BACKUP_DIR/" && info "Backed up $f"
done
for config_file in "$HOME/.config/starship.toml" "$HOME/.config/ghostty/config" "$HOME/.config/cmux/settings.json"; do
    [ -f "$config_file" ] && cp "$config_file" "$BACKUP_DIR/" && info "Backed up $(basename $config_file)"
done
info "Backup saved to $BACKUP_DIR"

# ========== Homebrew ==========
if ! command -v brew &>/dev/null; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    info "Homebrew already installed"
fi

# ========== Brew 依赖 ==========
info "Installing brew packages..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

# ========== fzf ==========
if [ ! -f "$HOME/.fzf.zsh" ]; then
    info "Setting up fzf..."
    $(brew --prefix)/opt/fzf/install --all --no-bash --no-fish
fi

# ========== 链接配置文件 ==========
info "Linking configuration files..."

ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
info "Linked .zshrc"

mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"
info "Linked starship.toml"

mkdir -p "$HOME/.config/ghostty"
ln -sf "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"
info "Linked ghostty config"

mkdir -p "$HOME/.config/cmux"
ln -sf "$DOTFILES_DIR/cmux/settings.json" "$HOME/.config/cmux/settings.json"
info "Linked cmux settings"

# ========== secrets 模板 ==========
if [ ! -f "$HOME/.env.secrets" ]; then
    cp "$DOTFILES_DIR/zsh/.env.secrets.example" "$HOME/.env.secrets"
    warn "Created ~/.env.secrets from template - please fill in your API keys"
fi

# ========== 设置默认 shell ==========
if [ "$SHELL" != "$(which zsh)" ]; then
    info "Changing default shell to zsh..."
    chsh -s "$(which zsh)"
fi

echo ""
info "Installation complete!"
echo ""
echo "Next steps:"
echo "  1. Edit ~/.env.secrets and add your API keys"
echo "  2. Restart your terminal"
echo "  3. (Optional) Install additional tools: pnpm, bun, pyenv python versions, etc."
