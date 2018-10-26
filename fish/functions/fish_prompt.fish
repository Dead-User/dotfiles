function fish_prompt
	test $SSH_TTY
    and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '
    test "$USER" = 'root'
    and echo (set_color red)"#"

    # Main
    echo -n (set_color red)'['(set_color white)(prompt_pwd)(set_color red)']'\
            (set_color FFA0FF)'❯'(set_color A070A0)'❯'(set_color 703070)'❯ '
end

