
# Some issues:
# 1. For terminal issues, curretly kakoune holds the following maps:
#      <c-j> => <ret>
#      <c-m> => <ret>
#      <c-h> => <backspace>
#    These maps can not be removed without modifying kakoune's source.


# key maps
map global normal t h
map global normal n l
map global normal r k
map global normal h j

map global normal T H
map global normal N L
map global normal R K
map global normal H J

map global normal <c-t> b
map global normal <c-n> w

map global user   r <c-u>
map global user   h <c-d>
map global user   R <c-b>
map global user   H <c-f>

map global normal l x
map global normal L X

map global normal j n
map global normal J N
map global normal k <a-n>
map global normal K <a-N>

map global insert <c-f> <c-p>
map global insert <c-t> <c-n>

map global normal <space> ,
map global normal <ret> <space>

hook global WinSetOption filetype=(rust|ocaml) %{
    map window user t :lsp-hover<ret>
}
