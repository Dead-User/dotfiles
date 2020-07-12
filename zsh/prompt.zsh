
function __compress_path () {
  local pwd=$1
  [[ $# -eq 0 ]] && pwd="$PWD"
  local pwd_len=${#pwd}

  local home="$HOME"
  if [[ $pwd = '/' ]]; then
    echo '/'
    return
  fi
  if [[ $pwd = $home ]]; then
    echo '~'
    return
  fi
  if [[ $pwd = "$home/"* ]]; then
    local home_size=${#home}
    pwd="~${pwd:$home_size}"
    ((pwd_len -= $home_size - 1))
  fi

  if [[ $pwd_len -gt $PROMPT_PATH_MAX_LEN ]]; then
    local subs=("${(s:/:)pwd}")
    local count=${#subs[@]}
    local len=$pwd_len
    local index=1
    until [[ $index -ge $count || $len -le $PROMPT_PATH_MAX_LEN ]]; do
      local elem=${subs[$index]}
      if [[ -z $elem || ${#elem} -le 1 ]]; then
        ((index += 1))
        continue
      fi
      subs[$index]=${elem[1]}
      ((len -= ${#elem} - 1, index += 1))
    done
    local IFS='/'
    echo "$subs"
  else
    echo $pwd
  fi
}

if [[ $EUID -eq 0 ]]; then
  local color='#ff0000'
else
  local color='#ffd400'
fi
prompt off
export PROMPT=' %F{'$color'}$(__compress_path)%f > '
