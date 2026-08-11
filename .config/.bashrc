# Preferred Editor
export EDITOR='nvim'

# Modern Replacement Aliases (Ubuntu Specific)
alias ls='eza --icons'
alias ll='eza -l --icons --group-directories-first'
alias la='eza -la --icons --group-directories-first'
alias lt='eza --tree --level=2 --icons'

# Ubuntu binary name adjustments
alias cat='batcat --style=plain'
alias bat='batcat'
alias grep='rg'
alias find='fdfind'
alias fd='fdfind'
alias help='tldr'

# Shell Integrations
if command -v fzf &> /dev/null; then
    # fzf bash integration
    eval "$(fzf --bash)" 2>/dev/null || {
        [ -f /usr/share/doc/fzf/examples/key-bindings.bash ] && source /usr/share/doc/fzf/examples/key-bindings.bash
        [ -f /usr/share/doc/fzf/examples/completion.bash ] && source /usr/share/doc/fzf/examples/completion.bash
    }
fi

eval "$(starship init bash)"
eval "$(zoxide init bash)"
source /opt/ros/lyrical/setup.bash

# Auto-source workspace if it has been built
if [ -f "$HOME/RoboSub/install/setup.bash" ]; then
    source "$HOME/RoboSub/install/setup.bash"
fi

# Automatically jump to the RoboSub directory on startup
if [ -d "$HOME/RoboSub" ]; then
    cd "$HOME/RoboSub"
fi