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

# aliases
alias python313="/opt/homebrew/opt/python@3.13/libexec/bin/python3"
alias grep="grep --color=always"
alias ll="ls -la"
