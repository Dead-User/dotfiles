
bindkey -v

bindkey -a 't' vi-backward-char
bindkey -a 'n' vi-forward-char
bindkey -a 'r' up-line-or-beginning-search
bindkey -a 'h' down-line-or-beginning-search
bindkey -a 'T' vi-backward-word
bindkey -a 'N' vi-forward-word
bindkey -a '^t' vi-beginning-of-line
bindkey -a '^n' vi-end-of-line

bindkey -v '^n' autosuggest-accept
