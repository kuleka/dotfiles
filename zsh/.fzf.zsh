# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/yisu/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/yisu/.fzf/bin"
fi

# Auto-completion
# ---------------
source "/Users/yisu/.fzf/shell/completion.zsh"

# Key bindings
# ------------
source "/Users/yisu/.fzf/shell/key-bindings.zsh"
