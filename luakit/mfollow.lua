

local select = require "select"

select.label_maker = function (s)
  return s.sort(s.charset("aoeithnsudrl"))
end

local s = require "select_wm"
local modes = require "modes"

local hint_style = [===[
#luakit_select_overlay {
  position: absolute;
  left: 0
  top: 0
  z-index: 2147483647;
}

#luakit_select_overlay .hint_overlay {
    display: block;
    position: absolute;
    background-color: #ffff99;
    border: 1px dotted #000;
    opacity: 0.3;
}

#luakit_select_overlay .hint_label {
    display: block;
    position: absolute;
    background-color: #000088;
    border: 1px dashed #000;
    color: #fa0;
    font-size: 12px;
    font-family: Monaco;
    opacity: 0.4;
}

#luakit_select_overlay .hint_overlay_body {
    background-color: #ff0000;
}

#luakit_select_overlay .hint_selected {
    background-color: #00ff00 !important;
}
]===]

local selectors = {
  "a, area, textarea, select, input:not([type=hidden]), button",
  "area, area, textarea, select, input:not([type=hidden]), button, body, applet, object",
  "a, area",
  "*[title], img[alt], applet[alt], area[alt], input[alt]",
  "img, [type=image]",
  "a img"
}

modes.new_mode("goto", {
  name = "goto",
  enter = function (w, mode)
    assert(type(mode) == "table", "not a valid mode!")
    --s.enter(w.view, (selectors[mode.selector] or 1), hint_style, false)
    w:set_prompt("goto: ")
    w:set_input()
    print("entered follow mode")
  end,
  passthrough = true,

  changed = function (w, text)
    if text == "" then
      return
    end
    local ht, cnt = s.changed(w.view, nil, nil, text)
    if cnt == 1 then
      local uri = ht[1].uri
      if mode.func then
        mode.func(uri)
      else
        w:navigate(uri)
      end
    end
  end,

  leave = function (w)
    print("quit follow mode")
    s.leave(w.view)
  end
},
true)


modes.add_binds("goto", {
  {"<Tab>", "switch to next selector", function (w, mode)
    w:set_mode("goto", {
      selector = (mode.selector + 1) or 1,
      func = mode.func
    })
  end },
  {"<Shift-Tab>", "switch to previous selector", function (w, mode)
    w:set_mode("goto", {
      selector = (mode.selector - 1) or 1,
      func = mode.func
  })
  end },
  {"<Escape>", "exit goto mode", function (w, _)
    print(w.mode.name)
    w:set_prompt()
    w:set_mode()
    print(w.mode.name)
  end }
})

modes.add_binds("normal", {
  {"f", "enter follow mode", function (w, _)
    w:set_mode("goto", {
      selector = 1,
      func = function (uri)
        w:navigate(uri)
      end
    })
  end },
  {"F", "enter follow mode, open new tab", function (w, _)
    w:set_mode("goto", {
      selector = 1,
      func = function (uri)
        w:new_tab(uri)
      end
    })
  end }
})

