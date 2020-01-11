

define-command tabe \
  -params 1 \
  -file-completion \
  -docstring "edit a file in a new terminal" \
  %{
      nop %sh{ 
        setsid -f new-terminal --no-popup --exec kak -c $kak_session $1 < /dev/null > /dev/null 2>&1 &
  }}


define-command make \
  -params 0 \
  -override \
  -docstring "make in a new popup (floating) terminal" \
  %{
      nop %sh{
          setsid -f new-terminal --exec run-prog $kak_config/x11util.sh $kak_opt_filetype make < /dev/null > /dev/null 2>&1 & 
      }
  }

define-command run \
  -params 0 \
  -override \
  -docstring "execute in a new popup (floating) terminal" \
  %{
      nop %sh{
          setsid -f new-terminal --exec run-prog $kak_config/x11util.sh $kak_opt_filetype run < /dev/null > /dev/null 2>&1 &
      }
  }


define-command test \
  -params 0 \
  -override \
  -docstring "test in a new popup (floating) terminal" \
  %{
      nop %sh{
          setsid -f new-terminal --exec run-prog $kak_config/x11util.sh $kak_opt_filetype test < /dev/null > /dev/null 2>&1 &
      }
  }

