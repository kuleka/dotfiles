# Dotfiles

macOS 终端环境配置：Zsh + Starship + Ghostty/cmux + Catppuccin Mocha 主题。

## 包含什么

| 文件 | 作用 |
|---|---|
| `zsh/.zshrc` | Shell 配置（历史、补全、插件、PATH、alias） |
| `zsh/.env.secrets.example` | API keys 模板 |
| `starship/starship.toml` | Starship 提示符主题（Catppuccin Mocha 配色，显示 git/语言环境） |
| `ghostty/config` | Ghostty/cmux 终端配置（Maple 字体、透明度、快捷键、Catppuccin 主题） |
| `cmux/settings.json` | cmux 侧边栏外观 |
| `Brewfile` | Homebrew 安装清单（仅终端工具） |
| `install.sh` | 一键安装脚本 |

## 一键安装

```bash
git clone git@github.com:kuleka/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

脚本会自动：
1. 备份现有配置到 `~/.dotfiles_backup_YYYYMMDD_HHMMSS/`
2. 安装 Homebrew（如果没有）
3. 通过 Brewfile 安装所有终端工具和字体
4. 配置 fzf
5. 软链接所有配置文件到正确位置
6. 创建 `~/.env.secrets` 模板

## 安装后

1. **填写 API keys**：编辑 `~/.env.secrets`，参考 `zsh/.env.secrets.example`
2. **重启终端**
3. **按需安装其他工具**：pnpm、bun、pyenv python 版本、Docker、AWS CLI 等

## Brew 安装的终端工具

| 工具 | 作用 |
|---|---|
| `starship` | 跨 shell 提示符 |
| `zsh-autosuggestions` | 历史命令灰色建议 |
| `zsh-syntax-highlighting` | 命令语法高亮 |
| `thefuck` | 输错命令后输入 `fuck` 自动纠正 |
| `fzf` | 模糊搜索（Ctrl+R 搜历史，Ctrl+T 搜文件） |
| `fd` | 更快的 `find` 替代 |
| `yazi` | 终端文件管理器 |

## 文件链接关系

```
~/dotfiles/zsh/.zshrc             -> ~/.zshrc
~/dotfiles/starship/starship.toml -> ~/.config/starship.toml
~/dotfiles/ghostty/config         -> ~/.config/ghostty/config
~/dotfiles/cmux/settings.json     -> ~/.config/cmux/settings.json
```

修改 dotfiles 仓库里的文件会直接生效（软链接），方便同步。

## 恢复备份

如果新配置有问题：

```bash
cp ~/.dotfiles_backup_XXXXXXXX/.zshrc ~/.zshrc
source ~/.zshrc
```
