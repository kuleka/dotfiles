# Dotfiles

My personal zsh and oh-my-zsh configuration files for macOS.

## Features

- **Zsh** with **oh-my-zsh** framework
- **Powerlevel10k** theme for beautiful prompts
- Useful plugins: `git`, `fzf`, `zsh-autosuggestions`, `zsh-syntax-highlighting`
- **fzf** for fuzzy finding
- **thefuck** for command correction
- Support for common development tools: pyenv, conda, pnpm, docker, etc.

## Quick Start

### 1. Clone this repository

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
```

### 2. Run the installation script

```bash
chmod +x install.sh
./install.sh
```

### 3. Customize your configuration

Edit `~/.zshrc` and add your personal settings:

- **API Keys**: Add your OpenAI API key and other secrets
- **Firebase Credentials**: Set path to your Firebase credential files
- **SSH Aliases**: Add your server connection shortcuts
- **Custom Paths**: Add any additional PATH exports you need

### 4. Restart your terminal

```bash
# Or reload configuration
source ~/.zshrc
```

### 5. Configure Powerlevel10k (Optional)

```bash
p10k configure
```

## File Structure

```
dotfiles/
├── install.sh              # Installation script
├── README.md               # This file
├── zsh/
│   ├── .zshrc              # Main zsh configuration (sanitized)
│   ├── .p10k.zsh           # Powerlevel10k theme configuration
│   ├── .fzf.zsh            # fzf configuration
│   └── .zshenv             # zsh environment variables
└── oh-my-zsh/
    └── custom/             # oh-my-zsh custom plugins and themes
        ├── plugins/
        └── themes/
```

## Dependencies

The installation script will automatically install:

- **Homebrew** (if not already installed)
- **zsh**, **git**, **fzf**, **thefuck**
- **oh-my-zsh**
- **Powerlevel10k** theme
- **zsh-autosuggestions** plugin
- **zsh-syntax-highlighting** plugin

## Manual Installation

If you prefer to install manually:

1. Install oh-my-zsh
2. Install Powerlevel10k theme
3. Install zsh plugins
4. Copy configuration files to your home directory
5. Install required tools via Homebrew

## Backup

The installation script automatically creates a backup of your existing configuration in `~/.dotfiles_backup_YYYYMMDD_HHMMSS/`.

## Security Note

⚠️ **Important**: This configuration template has been sanitized to remove sensitive information. You must add your own:

- API keys and tokens
- SSH keys and server information
- Firebase credentials
- Personal paths and configurations

Never commit sensitive information to version control!

## Customization

Feel free to modify the configuration files to match your preferences:

- Edit `.zshrc` for shell configuration
- Edit `.p10k.zsh` for prompt customization
- Add custom plugins in `oh-my-zsh/custom/plugins/`
- Add custom themes in `oh-my-zsh/custom/themes/`

## Troubleshooting

### Permission Issues
```bash
chmod +x install.sh
```

### Plugin Not Working
```bash
source ~/.zshrc
```

### Theme Issues
```bash
p10k configure
```

## Contributing

This is a personal configuration repository, but feel free to fork and adapt it for your own use.

## License

MIT License - feel free to use and modify as needed.