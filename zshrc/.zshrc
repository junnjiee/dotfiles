eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# enable fzf powered tab completions for zoxide
autoload -Uz compinit
compinit

eval "$(zoxide init zsh --cmd cd)"
eval "$(starship init zsh)"
eval "$(mise activate zsh)"

alias ls='eza -1l --group-directories-last --icons=always'
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
