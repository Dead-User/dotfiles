
set fish_greeting ''
# set __fish_bin_dir[2] $SCRIPTS_DIR
set -gx PATH $SCRIPTS_DIR $PATH
set -gx MANPATH '/usr/share/man' $MANPATH

function fish_user_key_bindings
  bind t 'backward-char'
  bind T 'backward-word'
  bind n 'forward-char'
  bind N 'forward-word'
  bind r 'up-or-search'
  bind h 'down-or-search'

  bind a 'beginning-of-line'
  bind e 'end-of-line'

  bind dw 'backward-kill-word'
  bind dW 'kill-word'
  bind -k space 'complete'


  bind -M insert \cn 'forward-char'
  bind -M insert \ct 'backward-kill-word'
end

alias nv nvim

# opam configuration
source /home/usr0/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# if status -l
#   startx
# end
