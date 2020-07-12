
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

typeset -A ZSH_HIGHLIGHT_STYLES

# larger postfix, deeper color
local normal='#feeeed'
local red1='#ff0000'
local red2='#ef5b8c'
local orange1='#f36c21'
local orange2='#f58220'
local blue1='#76becc'
local blue2='#009ad6'
local green1='#7fb801'
local yellow1='#ffe600'
local yellow2='#ffd400'
local yellow3='#fcaf17'

# main
ZSH_HIGHLIGHT_STYLES[default]=fg=$normal
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=$orange1
ZSH_HIGHLIGHT_STYLES[builtin]=fg=$orange2
ZSH_HIGHLIGHT_STYLES[alias]=fg=$orange2
ZSH_HIGHLIGHT_STYLES[command]=fg=$orange2
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=$red1
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=$blue2
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=$blue2
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=$yellow2
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=$yellow2
ZSH_HIGHLIGHT_STYLES[redirection]=fg=$yellow1
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=$yellow1
# ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]=fg=$yellow1
# ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]=fg=$yellow1
ZSH_HIGHLIGHT_STYLES[command-substitution]=fg=none

# bracket
ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=$red2
ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=$green1
ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=$blue1
