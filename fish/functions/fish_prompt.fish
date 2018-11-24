function fish_prompt
	test $SSH_TTY
    and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '
    test "$USER" = 'root'
    and echo (set_color red)"#"

    # Main
    echo -n (set_color bfafbf)'['(set_color efdfef)(prompt_pwd)(set_color bfafbf)']'\
            (set_color efdfef)'❯'(set_color bfafbf)'❯'(set_color 7f6f7f)'❯ '
end

