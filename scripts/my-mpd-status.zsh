#!/usr/bin/env zsh

pause=0.5
width=10

help_msg='
  my-mpd-status OPTS: print current played file name of mpd within a fixed
      display width, scroll the file name if it is too long.
  OPTS:
      -pause -p PAUSE: how many seconds to pause between scrolling
      -width -w WIDTH: the width limit for output, in latin characters
'
while [[ "${#*}" -gt 0 ]]; do
    case "$1" in
        ( '-p' | '-pause' )
            shift 1
            if [[ -z "$1" ]]; then
                echo "Bad option. No pause time specified" >&2
                exit 1
            else
                pause=$1
                shift 1
            fi
            ;;
        ( '-w' | '-width' )
            shift 1
            if [[ -z "$1" ]]; then
                echo "Bad option. No width specified" >&2
                exit 1
            else
                width=$1
                shift 1
            fi
            ;;
        ( '-h' | '-help' | '--help' | 'help' )
            echo $help_msg
            exit 0
            ;;
        ( * )
            echo "Unknown option $1." >&2
            echo $help_msg
            exit 1
            ;;
    esac
done

# calculate the display width of $1
function display_width() {
    input=$1
    i=0
    len=0
    while [[ "$i" -lt "${#input}" ]]; do
        if [[ "${input:(i):1}" == [[:ascii:]] ]]; then
            (( len = len + 1 ))
        else
            (( len = len + 2 ))
        fi
        (( i = i + 1 ))
    done
    echo $len
}

spaces="                 "
while [ 1 ]; do
    sleep $pause
    name=$(mpc -f %file% current \
      | sed -n 's/.\w\+$//g; p' \
      | awk -F/ '{ print $2 }')
    if [[ "$name" != "${buffer:1:(${#name})}" ]]; then
        offset=0
        range=0
        hole=$width
        buffer=" $name      $name"
        printf "name: %s\n" ${#name}
    fi
    if [[ $((offset + 1)) -eq $((${#buffer} - ${#name})) ]]; then
        offset=0
    fi
    if [[ $offset -eq 1 && $range -ge ${#name} || -z "$name" ]]; then
        printf '%s\n' "$name"
        continue
    fi
    popped=${buffer:(offset):1}
    (( offset = offset + 1,
       range = range - 1,
       hole = hole + $(display_width $popped)
    ))
    while [[ $hole -gt 0 ]]; do
        nextw=$(display_width ${buffer:(offset + range):1})
        if [[ $nextw -gt $hole ]]; then
            break
        else
            (( hole = hole - nextw, range = range + 1 ))
        fi
    done
    echo "${buffer:(offset):(range)}${spaces:0:(hole)}"
done
