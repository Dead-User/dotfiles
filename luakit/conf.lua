-- the user's own config file
-- seperated for compability

local modes = require "modes"
local opts = require "globals"

local actions = {
  scroll = {
    up = {
      desc = "scorll the page up",
      func = function (w, m)
        w:scroll{yrel = -opts.scroll_step * (m.count or 1)}
      end
    },
    down = {
      desc = "scroll the page down",
      func = function (w, m)
        w:scroll{yrel = opts.scroll_step * (m.count or 1)}
      end
    },
    left = {
      desc = "scroll the page left",
      func = function (w, m)
        w:scroll{xrel = -opts.scroll_step * (m.count or 1)}
      end
    },
    right = {
      desc = "scorll the page right",
      func = function (w, m)
        w:scroll{xrel = opts.scroll_step * (m.count or 1)}
      end
    },
    page_up = {
      desc = "scroll half page up",
      func = function (w, m)
        w:scroll{ypagerel = -opts.page_step * (m.count or 1)}
      end
    },
    page_down = {
      desc = "scroll half page down",
      func = function (w, m)
        w:scroll{ypagerel = opts.page_step * (m.count or 1)}
      end
    }
  },

  tab = {
    -- inter tab navigation
    prev = {
      desc = "switch to previous tab",
      func = function (w, m)
        w:prev_tab()
      end
    },
    next = {
      desc = "switch to the next or the [count]th tab",
      func = function (w, m)
        if m.count then
          w:goto_tab(m.count)
        else
          w:next_tab()
        end
      end
    },
    first = {
      desc = "switch to the first tab",
      func = function (w, m)
        w:goto_tab(1)
      end
    },
    last = {
      desc = "switch to the last tab",
      func = function (w, m)
        w:goto_tab(-1)
      end
    },
    -- tab manipulation
    open = {
      desc = "open link in current tab",
      func = function (w, m)
        w:enter_cmd(":open ")
      end
    },
    new = {
      desc = "open new tab",
      func = function (w, m)
        w:enter_cmd(":tabopen ")
      end
    },
    reload = {
      desc = "reload current tab",
      func = function (w, m)
        w:reload()
      end
    },
    hard_reload = {
      desc = "reload current tab, skipping cache",
      func = function (w, m)
        w:reload(true)
      end
    }
  },

  history = {
    back = {
      desc = "move backward [count=1] in history",
      func = function (w, m)
        w:back(1)
      end
    },
    forward = {
      desc = "move forward [count=1] in history",
      func = function (w, m)
        w:forward(1)
      end
    }
  }
}

modes.remove_binds("normal",{"t", "n", "r", "h", "<Control-H>", "<Control-R>"})
modes.add_binds("normal",{
  -- page navigation
  {"r", actions.scroll.up},
  {"h", actions.scroll.down},
  {"T", actions.scroll.left},
  {"N", actions.scroll.right},
  {"R", actions.scroll.page_up},
  {"H", actions.scroll.page_down},
  -- tab navigation
  {"t", actions.tab.prev},
  {"n", actions.tab.next},
  -- tab manipulation
  {"o", actions.tab.open},
  {"O", actions.tab.new},
  {"x", actions.tab.reload},
  {"X", actions.tab.hard_reload},
  {"<Control-h>", actions.history.back},
  {"<Control-r>", actions.history.forward}
})

modes.add_cmds({
  {":w[rite]", "save current session", function (w)
    w:save_session()
  end },
  {":nt[ab]", "open new tab", {
    func = function (w, o)
      w:new_tab(w:search_open(o.arg))
    end,
    format = "{uri}"
  }},
  {":nw[indow]", "open new window", {
    func = function (w, o)
      window.new{w:search_open(o.arg)}
    end,
    format = "{uri}"
  }},
})


local select = require "select"
local follow = require "follow"

select.label_maker = function (s)
  return s.sort(s.charset("atohenisdlur"))
end

follow.pattern_maker = follow.pattern_styles.match_label
follow.ignore_case = true
