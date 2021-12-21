(local wezterm (require :wezterm))
(local M {})

(fn set-options [tbl options]
  (each [key value (pairs options)]
    (tset tbl key value)))

(local theme {:dark "Github Dark" :light "Github"})

(wezterm.on 
  :theme-toggle 
  (fn [window pane]
    (let [overrides (or (window:get_config_overrides) {})]
      (if (= overrides.color_scheme theme.light)
        (set overrides.color_scheme theme.dark)
        (set overrides.color_scheme theme.light))
      (window:set_config_overrides overrides))))

(set-options M 
             {:default_prog [:fish]
              :enable_wayland true
              :enable_tab_bar false
              :color_scheme theme.dark
              :keys [{:key :E :mods :CTRL|SHIFT
                      :action (wezterm.action {:EmitEvent :theme-toggle})}]})

M ; export
