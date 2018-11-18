vimfx.set("hints.chars", "ehonituras dl")
vimfx.set("config_file_directory", "~/dotfiles/vimFx")
vimfx.set("mode.normal.focus_search_bar", "<c-s>")
vimfx.set("mode.normal.history_back", "<c-h>")
vimfx.set("mode.normal.history_forward", "<c-r>")

vimfx.set("mode.normal.reload", "x")
vimfx.set("mode.normal.reload_force", "X")
vimfx.set("mode.normal.reload_all", "ax")
vimfx.set("mode.normal.reload_all_force", "aX")

vimfx.set("mode.normal.scroll_left", "T")
vimfx.set("mode.normal.scroll_right", "N")
vimfx.set("mode.normal.scroll_down", "h")
vimfx.set("mode.normal.scroll_up", "r")
vimfx.set("mode.normal.scroll_half_page_down", "H")
vimfx.set("mode.normal.scroll_half_page_up", "R")

vimfx.set("mode.normal.tab_new", "")
vimfx.set("mode.normal.tab_new_after_current", "O")
vimfx.set("mode.normal.tab_select_previous", " t")
vimfx.set("mode.normal.tab_select_next", " n")
vimfx.set("mode.normal.tab_close", "d")
vimfx.set("mode.normal.tab_restore", "D")

vimfx.set("mode.normal.find_next", "<c-n>")
vimfx.set("mode.normal.find_previous", "<c-N>")

vimfx.set("mode.caret.move_left", "t")
vimfx.set("mode.caret.move_right", "n")
vimfx.set("mode.caret.move_down", "h")
vimfx.set("mode.caret.move_up", "r")
vimfx.set("mode.caret.move_word_left", "T")
vimfx.set("mode.caret.move_word_right", "N")

vimfx.set("prevent_target_blank", false)
let {commands} = vimfx.modes.normal
vimfx.addCommand({
  name: 'search_tabs',
  description: 'Search tabs',
  category: 'tabs',
  order: commands.focus_location_bar.order + 1,
}, (args) => {
  let {vim} = args
  let {gURLBar} = vim.window
  gURLBar.value = ''
  commands.focus_location_bar.run(args)
  // Change the `*` on the text line to a `%` to search tabs instead of bookmarks.
  gURLBar.value = '* '
  gURLBar.onInput(new vim.window.KeyboardEvent('input'))
})
vimfx.set("custom.mode.normal.search_tabs", "b")
