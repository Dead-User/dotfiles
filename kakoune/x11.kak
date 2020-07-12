

define-command term \
  -params .. \
  -shell-completion \
  -docstring "open a new popup (floating) terminal"  %{
      nop %sh{
          setsid -f new-terminal $@ </dev/null >/dev/null 2>&1 &
      }
  }

define-command tab \
  -params 1.. \
  -command-completion \
  -docstring "do stuffs in a new tab (terminal)" \
  %{
        term --no-popup --exec kak -c %val{session} -e "'%arg{@}'"
        # echo kak -c %val{session} -e "'%arg{@}'"
  }

define-command tabq \
  -params 0 \
  -docstring "quit a tab (separate window) and delete the buffer" \
  %{
      delete-buffer
      quit
  }
alias global tq tabq

define-command tabwq \
  -params 0 \
  -docstring "write quit a tab (separate window) and delete the buffer" \
  %{
      write
      delete-buffer
      quit
  }
alias global twq tabwq


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

