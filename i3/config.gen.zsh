#!/usr/bin/env zsh

# This is my i3 config v2.0. Instead of a static config file,
# this is a config generator. That is, it dynamically generate
# config(s) with different settings
# This generator is not intended to be a general library any
# user can use. Instead, it only captures the parts of the
# config that may vary on every run

########## Part I. Arg Parsing ##########
THEME="dark"
while [[ ! -z $1 ]]; do
    case $1 in
        '-theme' )
            shift 1
            if [[ ! -z $1 ]]; then
                THEME=$1
                shift 1
            else
                echo "no theme specified" > ~/.config/i3/log
                exit 1
            fi;;
         * )
             echo "unknown option $1" > ~/.config/i3/log
             exit 1;;
    esac
done



########## Part II. Load Config ##########

# The theme file should define the following stuffs:
# 1. COLOR_FOCUSED, COLOR_UNFOCUSED, COLOR_FOCUSED_INACTIVE:
#       5-element array of respective color classes:
#           border background text indicator child-border
# 2. BGSET(optional):
#       the name of the BG set to use
# 3. FONTS:
#       a list of fonts to use. Form: "font_name font_size"
# 4. TERMINAL_CMD:
#       the command of launching a terminal emulator
# 5. PROGRAM_LAUNCHER:
#       the command to launch programs, dmenu, rofi, etc.
# 6. EXTRA_SETTINGS:
#       a string of extra settings (may overwrite existing ones)
# 7. EXTRA_INITS:
#       a string of extra init commands
source ~/.config/i3/theme/$THEME.zsh




########## Part III. Global Definitions ##########

# TODO: abstract this out to a 'machine' file
DISPLAY=(eDP1 DP1)

# in case workspace order need to be modified later...
# such  a pity zsh does not support nested array
declare -A WS_INDEX
WS_INDEX=( [web]=1 [edit]=2 [emu]=3 [media]=4 [sys]=5 [net]=6 )
declare -A WS_DISPLAY
WS_DISPLAY=( [web]=2 [edit]=2 [emu]=2 [media]=2 [sys]=1 [net]=1 )

Mod=Mod4
# my custom, wierd, 'scientific' keyboard layout ;)
Up=r
Down=h
Left=t
Right=n


########## Part IV. Global Settings ##########
for font in $FONTS; do
    echo font pango:$font
done

echo default_border                pixel 3
echo hide_edge_borders             both
echo smart_borders                 on

echo gaps                          inner 10
echo gaps                          outer 0

echo client.focused                $COLOR_FOCUSED
echo client.unfocused              $COLOR_UNFOCUSED
echo client.focused_inactive       $COLOR_FOCUSED_INACTIVE

echo default_orientation           horizontal
echo focus_wrapping                yes
echo focus_follows_mouse           no
echo workspace_auto_back_and_forth no

echo floating_modifier             $Mod

for name index in ${(kv)WS_INDEX}; do
    echo workspace $index:$name output Display${WS_DISPLAY[$name]}
done
# echo 'workspace "1:web"   output $Display2'
# echo 'workspace "2:edit"  output $Display2'
# echo 'workspace "3:win"   output $Display2'
# echo 'workspace "4:media" output $Display2'
# echo 'workspace "5:game"  output $Display2'
# echo 'workspace "6:sys"   output $Display1'
# echo 'workspace "7:net"   output $Display1'

echo for_window \[class=\"feh\"    \] floating enable
echo for_window \[class=\"feh\"    \] border   none
 
# it is 'firefox' on arch, but 'Firefox' on gentoo,
# and 'Nightly' for newer versions...
echo for_window \[class=\"Firefox\"\] border none
echo for_window \[class=\"firefox\"\] border none
echo for_window \[class=\"Nightly\"\] border none

echo for_window \[class=\"Wine\"   \] floating enable

# extremely useful convention for custom scripts
echo for_window \[class=\"popup\"  \] floating enable
echo for_window \[instance=\"popup\"\] floating enable
echo for_window \[class=\"popup\"  \] move position center

function assign_window() {
    echo assign \[class=\"$1\"\] $WS_INDEX[$2]:$2
}
assign_window Firefox    web
assign_window firefox    web
assign_window Nightly    web
assign_window vimb       web
assign_window Virtualbox emu
assign_window VirtualBox emu
assign_window Wine       emu
assign_window PPSSPPSDL  emu
assign_window gFTP       net

echo $EXTRA_SETTINGS



######### Part V. Init ##########
# custom script to launch status bar
echo exec launch-bar 0
echo exec launch-bar 1

echo exec mpd

# input method
echo exec fcitx

echo $EXTRA_INITS

if [[ ! -z $BGSET ]]; then
    echo exec random-bg $BGSET
fi



########## Part VI. Key Bindings ##########
function bindsym() {
    key=$1
    shift 1
    action="${*[@]:1}"
    echo bindsym $Mod+$key $action
}


# Focusing
bindsym $Left          focus left
bindsym $Right         focus right
bindsym $Up            focus up
bindsym $Down          focus down

bindsym Shift+$Left    move left
bindsym Shift+$Right   move right
bindsym Shift+$Up      move up
bindsym Shift+$Down    move down

bindsym minus           resize shrink width  10 px or 10 ppt
bindsym equal           resize grow   width  10 px or 10 ppt
bindsym Shift+minus     resize shrink height 10 px or 10 ppt
bindsym Shift+equal     resize grow   height 10 px or 10 ppt

bindsym p              focus parent
bindsym c              focus child

bindsym space          focus mode_toggle

function move_to_workspace() {
    option=$1
    target=$2
    case $option in
        focus )
            if [[ -z $BGSET ]]; then
                echo workspace $target
            else
                # random-bg is a custom script
                echo "workspace $target; exec random-bg $BGSET"
            fi;;
        container )
            echo move container to workspace $target;;
    esac
}
for name index in ${(kv)WS_INDEX}; do
    bindsym $index       $(move_to_workspace focus     $index:$name)
    bindsym Shift+$index $(move_to_workspace container $index:$name)
done
bindsym a $(move_to_workspace focus prev)
bindsym o $(move_to_workspace focus next)

bindsym Shift+a $(move_to_workspace container prev)
bindsym Shift+o $(move_to_workspace container next)


bindsym Control+t      layout tabbed
bindsym Control+s      layout stacking
bindsym Control+h      layout splith
bindsym Control+v      layout splitv
bindsym f              floating enable

bindsym Return         exec $TERMINAL_CMD
bindsym s              exec $PROGRAM_LAUNCHER

bindsym Shift+Return   scratchpad
bindsym Shift+s        move scratchpad

bindsym Shift+q        kill

echo mode \"layout\" \{
( echo bindsym t       focus left
  echo bindsym n       focus right
  echo bindsym r       focus up
  echo bindsym n       focus down

  echo bindsym p       focus parent
  echo bindsym c       focus child

  echo bindsym Shift+t move left
  echo bindsym Shift+n move right
  echo bindsym Shift+r move up
  echo bindsym Shift+n move down

  echo bindsym minus       resize shrink width  10 px or 10 ppt
  echo bindsym equal       resize grow   width  10 px or 10 ppt
  echo bindsym Shift+minus resize shrink height 10 px or 10 ppt
  echo bindsym Shift+equal resize grow   height 10 px or 10 ppt

  echo bindsym Control+s layout stacking
  echo bindsym Control+t layout tabbed
  echo bindsym Control+h layout splith
  echo bindsym Control+v layout splitv
  echo bindsym f         floating toggle

  echo bindsym a         move_to_workspace focus prev
  echo bindsym o         move_to_workspace focus next

  for name index in ${(kv)WS_INDEX}; do
      echo bindsym $index         $(move_to_workspace focus     $index:$name)
      echo bindsym Shift+$index   $(move_to_workspace container $index:$name)
  done
  echo bindsym Shift+a $(move_to_workspace container prev)
  echo bindsym Shift+o $(move_to_workspace container next)

  echo bindsym Control+1 move workspace to output ${DISPLAY[1]}
  echo bindsym Control+2 move workspcae to output ${DISPLAY[2]}
  echo bindsym k         move workspace to output left
  echo bindsym j         move workspace to output right

  echo bindsym Escape  mode \"default\"
  echo bindsym Return  mode \"default\"
  echo bindsym $Mod+l  mode \"default\" )
echo \}
bindsym l              mode \"layout\"

bindsym Control+r       reload
bindsym Control+x       restart
# new-terminal and exit-i3 are custom scripts.
# in effect, a popup window prompting the user to
# confirm exiting i3 will be opened
bindsym Control+q       exec new-terminal --exec exit-i3


echo mode \"floating\" \{
# here $Mod is NOT needed, so use 'echo bindsym ...' directly
( echo bindsym $Left  resize shrink width  10 px or 10 ppt
  echo bindsym $Right resize grow   width  10 px or 10 ppt
  echo bindsym $Up    resize shrink height 10 px or 10 ppt
  echo bindsym $Down  resize grow   height 10 px or 10 ppt
  
  echo bindsym Return mode \"default\"
  echo bindsym Escape mode \"default\"
  echo bindsym $Mod+c mode \"default\" )
echo \}

# bindsym f mode \"floating\"

echo mode \"menu\" \{
( echo bindsym r     exec amixer set Master 5%+
  echo bindsym h     exec amixer set Master 5%-

  echo bindsym t     exec mpc prev
  echo bindsym n     exec mpc next
  echo bindsym space exec mpc toggle

  echo bindsym q     exec light -A 5
  echo bindsym a     exec light -U 5

  echo bindsym Return mode \"default\"
  echo bindsym Escape mode \"default\"
  echo bindsym $Mod+c mode \"default\" )
echo \}

bindsym m mode \"menu\"
