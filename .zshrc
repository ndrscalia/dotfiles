export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
export PATH="$HOME/.virtualenvs/neovim/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.14/libexec/bin:$PATH"

export EDITOR=nvim
export VISUAL=nvim

# make `ls` colorize its output
export CLICOLOR=1

# enable 24-bit colors
if [[ -z "$TMUX" ]]; then
  export TERM=xterm-256color
fi
export COLORTERM=truecolor

eval "$(oh-my-posh init zsh --config ~/dotfiles/.config/ohmyposh/amro-enhanced.omp.json)"
#eval "$(oh-my-posh init zsh --config ~/dotfiles/.config/ohmyposh/gruvbox-enhanced.omp.json)"
eval "$(zoxide init zsh)"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^O' autosuggest-accept

# With these lines you can edit long commands in nvim with `ctrl+x+e`
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# Custom functions
fzfgrep() {
    grep -n '' "$1" | fzf --delimiter=: \
      --preview "awk -v n={1} -v q={q} 'NR>=n-5 && NR<=n+5 {if(NR==n) {gsub(q, \"\033[7m&\033[0m\"); print} else print}' $1" \
      --preview-window=up:12
}

fzfrg() {
    if [ -z "$1" ]; then
        rg --color=always --line-number --no-heading --smart-case "" | fzf --ansi \
          --color "hl:-1:underline,hl+:-1:underline:reverse" \
          --delimiter : \
          --preview "bat --color=always {1} --highlight-line {2}" \
          --preview-window 'up,12,border-bottom,+{2}+3/3,~3'
    else
        rg --color=always --line-number --no-heading --smart-case "" "$1" | fzf --ansi \
          --color "hl:-1:underline,hl+:-1:underline:reverse" \
          --delimiter : \
          --preview "bat --color=always $1 --highlight-line {1}" \
          --preview-window 'up,12,border-bottom,+{1}+3/3,~3'
    fi
}

# switch theme across kitty, tmux, and nvchad
theme() {
    local kitty_dir=~/dotfiles/.config/kitty
    local tmux_dir=~/dotfiles/.config/tmux
    local chadrc=~/dotfiles/.config/nvim/lua/chadrc.lua

    case "$1" in
        dark)
            local kitty_theme="tokyonight"
            local nvim_theme="tokyonight"
            local omp_theme="amro-enhanced"
            ;;
        light)
            local kitty_theme="rosepine-dawn"
            local nvim_theme="rosepine-dawn"
            local omp_theme="gruvbox-enhanced"
            ;;
        *)
            echo "Usage: theme [dark|light]"
            return 1
            ;;
    esac

    # kitty: update theme file and live-reload colors
    cp "$kitty_dir/${kitty_theme}-theme.conf" "$kitty_dir/current-theme.conf"
    kitten @ set-colors --all --configured "$kitty_dir/current-theme.conf" 2>/dev/null \
        || echo "Kitty: restart or press ctrl+shift+f5 to reload"

    # tmux: update theme file and reload config
    cp "$tmux_dir/${kitty_theme}-theme.conf" "$tmux_dir/current-theme.conf"
    tmux source-file "$tmux_dir/tmux.conf" 2>/dev/null

    # nvchad: update chadrc and recompile base46 cache
    sed -i '' "s/theme = \".*\"/theme = \"${nvim_theme}\"/" "$chadrc"
    nvim --headless -c "lua require('base46').compile()" -c "qa" 2>/dev/null

    # oh-my-posh: re-init prompt with the matching theme
    eval "$(oh-my-posh init zsh --config ~/dotfiles/.config/ohmyposh/${omp_theme}.omp.json)"

    echo "Switched to $1 theme."
}

# aliases
alias python313="/opt/homebrew/opt/python@3.13/libexec/bin/python3"
alias grep="grep --color=always"
alias ll="ls -la"
