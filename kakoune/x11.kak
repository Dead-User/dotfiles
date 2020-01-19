

define-command term \
  -params .. \
  -shell-completion \
  -docstring "open a new popup (floating) terminal"  %{
      nop %sh{
          setsid -f new-terminal $@ < /dev/null > /dev/null 2>&1 &
      }
  }

define-command tabe \
  -params 1 \
  -file-completion \
  -docstring "edit a file in a new terminal" \
  %{
      term --no-popup --exec kak -c %val{session} %arg{1}
  }


define-command make \
  -params .. \
  -override \
  -docstring "make in a new popup (floating) terminal" \
  %{
      term --exec run-prog "%val{config}/x11util.sh" "%opt{filetype}" make %arg{@}
  }

define-command run \
  -params .. \
  -override \
  -docstring "execute in a new popup (floating) terminal" \
  %{
      term --exec run-prog "%val{config}/x11util.sh" "%opt{filetype}" run %arg{@}
  }


define-command test \
  -params .. \
  -override \
  -docstring "test in a new popup (floating) terminal" \
  %{
      term --exec run-prog "%val{config}/x11util.sh" "%opt{filetype}" test %arg{@}
  }

