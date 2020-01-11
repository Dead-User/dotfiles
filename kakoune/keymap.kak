
# Some issues:
# 1. For terminal issues, curretly kakoune holds the following maps:
#      <c-j> => <ret>
#      <c-m> => <ret>
#      <c-h> => <backspace>
#    These maps can not be removed without modifying kakoune's source.


# key maps
map global normal t h    ; map global normal T H
map global normal n l    ; map global normal N L
map global normal r k    ; map global normal R K
map global normal h j    ; map global normal H J

map global normal <c-t> gh
map global normal <c-n> gl

map global normal k b    ; map global normal K B
map global normal j w    ; map global normal J W

map global user   r <c-u>; map global user   R <c-b>
map global user   h <c-d>; map global user   H <c-f>
map global user   t <a-h>; map global user   T Gi
map global user   n <a-l>; map global user   N Gl

map global normal l n    ; map global normal L N
map global normal f <a-n>; map global normal F <a-N>

map global insert <c-f> <c-p>
map global insert <c-t> <c-n>

map global normal <space> ,
map global normal <ret> <space>

hook global WinSetOption filetype=(rust|ocaml) %{
    map window user t :lsp-hover<ret>
}



# An overview of the whole keymap
#    +------------+------------+------------+------------+------------+------------+------------+------------+------------+------------+
#    |Mac Record  |Delete      |Undo        |            |            |            |Search Prev |Up          |Search Next |            | 
# S  |Mac Play    |            |Redo        |            |            |            |(Expand)    |(Expand)    |(Expand)    |            |
# C  |            |            |            |            |            |            |            |            |            |            |
# U  |            |            |            |            |            |            |            |Half Pg Up  |            |            |
# U+S|            |            |            |            |            |            |            |Pg Up       |            |            |
#    +-----Q------+-----D------+-----U------+-----W------+-----B------+-----.------+-----F------+-----R------+-----L------+-----;------+
#    |Insert After|Insert NL   |            |Insert      |Yank        |Goto        |Left        |Down        |Right       |Select      |
# S  |Insert EOL  |Insert PL   |            |Insert BOL  |            |(Expand)    |(Expand)    |(Expand)    |(Expand)    |            |
# C  |            |            |            |            |            |            |NonEmpty BOL|            |EOL         |            |
# U  |            |            |            |            |            |            |Sel to BOL  |Half Pg Down|Sel to EOL  |            |
# U+S|            |            |            |            |            |            |(Expand)    |Pg Down     |(Expand)    |            |
#    +-----A------+-----O------+-----E------+-----I------+-----Y------+-----G------+-----T------+-----H------+-----N------+-----S------+
#    |            |Select Line |View        |Change      |            |Paste       |Select Match|Prev Word   |Next Word   | 
# S  |            |(Expand)    |Lock View   |Sel Nxt Line|            |            |(Expand)    |(Expand)    |(Expand)    |
# C  |            |            |            |            |            |            |            |            |            |
# U  |            |            |            |            |            |            |            |            |            |
# U+S|            |            |            |            |            |            |            |            |            |
#    +-----Z------+-----X------+-----V------+-----C------+-----,------+-----P------+-----M------+-----K------+-----J------+
#                                           |User                                               |
# S                                         |                                                   |
# C                                         |                                                   |
# U                                         |                                                   |
# U+S                                       |                                                   |
#                                           +-----------------------Space-----------------------+
