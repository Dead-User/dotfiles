
function fish_default_mode_prompt --description "Display the default mode for the prompt"
  # Do nothing if not in vi mode
  if test "$fish_key_bindings" = "fish_vi_key_bindings"
    or test "$fish_key_bindings" = "fish_hybrid_key_bindings"
    set_color normal
    echo [
    switch $fish_bind_mode
      case default
        echo (set_color ffc20e)'N'
      case insert
        echo (set_color ef4136)'I'
      case replace_one
        echo (set_color 33a3bc)'R'
      case visual
        echo (set_color 7fb801)'V' 
    end
    set_color normal
    echo ]
  end
end

