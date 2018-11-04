-- global value settings
--
local setting = {
  homepage            = "",
  scroll_step         = 40,
  page_step           = 0.5,
  zoom_step           = 0.1,
  max_cmd_history     = 100,
  max_srch_history    = 100,
  default_window_size = "1400x900",
  vertical_tab_width  = 200,
  term                = "alacritty"
}

setting.search_engines = {
  baidu     = "https://www.baidu.com/s?wd=",
  github    = "https://github.com/search?q=%s",
  wikipedia = "https://en.wikipedia.org/wiki/Special:Search?search=%s"
}

setting.search_engines.default = setting.search_engines.baidu

setting.domain_props = {
  ["all"] = {
    enable_webgl = true
  }
}

soup.accept_policy = "no_third_party"
soup.cookies_storage = luakit.data_dir .. "cookies.db"

return setting
