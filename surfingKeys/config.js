
unmap('t');
map('t', 'E');
unmap('n');
map('n', 'R');
unmap('r');
map('r', 'k');
unmap('h');
map('h', 'j');
unmap('T');
map('T', 'h');
unmap('N');
map('N', 'l');
// an example to remove mapkey `Ctrl-i`
unmap('<Ctrl-i>');

// set theme
settings.theme = `
.sk_theme {
    font-family: Monaco, sans-serif;
    font-size: 10pt;
    background: #202020;
    color: #EFDAE4;
}
.sk_theme tbody {
    color: #fff;
}
.sk_theme input {
    color: #d0d0d0;
}
.sk_theme .url {
    color: #61afef;
}
.sk_theme .annotation {
    color: #56b6c2;
}
.sk_theme .omnibar_highlight {
    color: #528bff;
}
.sk_theme .omnibar_timestamp {
    color: #e5c07b;
}
.sk_theme .omnibar_visitcount {
    color: #98c379;
}
.sk_theme #sk_omnibarSearchResult>ul>li:nth-child(odd) {
    background: #303030;
}
.sk_theme #sk_omnibarSearchResult>ul>li.focused {
    background: #3e4452;
}
#sk_status, #sk_find {
    font-size: 20pt;
}`;
