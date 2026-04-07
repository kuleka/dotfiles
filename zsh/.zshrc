# ========== 基础 zsh 配置 ==========
autoload -Uz compinit && compinit
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt share_history hist_ignore_dups hist_ignore_space

# ========== 插件（brew 安装）==========
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# ========== PATH ==========
export PATH="/opt/homebrew/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# ========== 环境变量 ==========
# API keys 从 ~/.env.secrets 加载（不入版本控制）
[ -f "$HOME/.env.secrets" ] && source "$HOME/.env.secrets"

# ========== 工具初始化 ==========
# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# thefuck
command -v thefuck &>/dev/null && eval $(thefuck --alias)

# Docker completions（装了 Docker 才加载）
[ -d "$HOME/.docker/completions" ] && fpath=($HOME/.docker/completions $fpath)

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# local bin env
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# ========== Alias ==========
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
alias ..='cd ..'
alias ...='cd ../..'

# ========== Starship prompt（放最后）==========
eval "$(starship init zsh)"

# syntax-highlighting 必须放在最后
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
