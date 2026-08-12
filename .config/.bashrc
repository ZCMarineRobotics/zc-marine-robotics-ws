# Preferred Editor
export EDITOR='nvim'

# Modern Replacement Aliases (Ubuntu Specific)
alias l='ls -lah'
alias ls='eza'
alias ll='eza -l --group-directories-first'
alias la='eza -la --group-directories-first'
alias lt='eza --tree --level=2'

# Ubuntu binary name adjustments
alias cat='batcat --style=plain'
alias bat='batcat'
alias grep='rg'
alias find='fdfind'
alias fd='fdfind'
alias help='tldr'

# ROS 2 Developer Aliases
alias cb='colcon build --symlink-install'
alias cbp='colcon build --symlink-install --packages-select'
alias rt='ros2 topic list'
alias rn='ros2 node list'
alias rdi='rosdep install --from-paths src --ignore-src -y'

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
if [ -n "$WS_DIR" ] && [ -f "$HOME/$WS_DIR/install/setup.bash" ]; then
    source "$HOME/$WS_DIR/install/setup.bash"
fi

# Automatically jump to the workspace directory on startup
if [ -n "$WS_DIR" ] && [ -d "$HOME/$WS_DIR" ]; then
    cd "$HOME/$WS_DIR"
fi