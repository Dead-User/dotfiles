
"[project-cmd.sh] is a shell script.
"And this is a simple wrapper for it.
"[new-terminal] spawn a new terminal emulator.
"[run-prog] simply runs its arguments, but pauses afterwards. 
function! ProjectCmd(cmd)
    call jobstart(["new-terminal", "--exec",
                 \ "run-prog", 
                 \ "project-cmd.sh", &l:filetype, a:cmd])
endfunction

command Make call ProjectCmd("make")
command Run  call ProjectCmd("run")
command Test call ProjectCmd("test")
