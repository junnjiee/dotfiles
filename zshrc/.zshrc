eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# enable fzf powered tab completions for zoxide
autoload -Uz compinit
compinit

eval "$(zoxide init zsh --cmd cd)"
eval "$(starship init zsh)"
eval "$(mise activate zsh)"

alias ls='eza -l --group-directories-last --icons=auto'
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

# amp
export PATH="$HOME/.local/bin:$PATH"
