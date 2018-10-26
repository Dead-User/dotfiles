function fish_default_mode_prompt --description "Display the default mode for the prompt"
    # Do nothing if not in vi mode
    if test "$fish_key_bindings" = "fish_vi_key_bindings"
        or test "$fish_key_bindings" = "fish_hybrid_key_bindings"
        set_color red
        echo '['
        set_color FFA0FF
        switch $fish_bind_mode
            case default
                echo 'N'
            case insert
                echo 'I'
            case replace_one
                echo 'R'
            case visual
                echo 'V'
        end
        set_color red
        echo ']'
        set_color normal
        echo -n ' '
    end
end

