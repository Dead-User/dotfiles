function fish_prompt
	test $SSH_TTY
    and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '
    test "$USER" = 'root'
    and echo (set_color red)"#"

    # Main
    echo -n (set_color 009ad6)'<'(set_color d3d7d4)(prompt_pwd)
    set_color normal
    echo (set_color 009ad6)'> '
end
