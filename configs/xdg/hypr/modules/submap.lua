---------------------
------ SUBMAPS ------
---------------------

local M = require("modules.vars")
local apps = M.apps
local base = M.bases

-- Helper fonction
-- local function sub_exec(cmd)
--     hl.exec_cmd(cmd)             -- Lance ton appli/config
--     hl.dsp.submap("reset")       -- Ferme le menu
--     hl.exec_cmd("pkill -RTMIN+9 waybar") -- Refresh la barre
-- end

-- Entrée dans le menu Système
hl.bind(base.mod .. " + Escape", hl.dsp.submap("󰐥"))
hl.define_submap("󰐥", function()
  -- Lock / Sleep / Power
  hl.bind("L", hl.dsp.exec_cmd("hyprlock"))
  hl.bind("L", hl.dsp.submap("reset"))
  hl.bind("L", hl.dsp.exec_cmd("pkill -RTMIN+9 waybar"))

  hl.bind("S", hl.dsp.exec_cmd("systemctl suspend"))
  hl.bind("S", hl.dsp.submap("reset"))
  hl.bind("S", hl.dsp.exec_cmd("pkill -RTMIN+9 waybar"))

  hl.bind("R", hl.dsp.exec_cmd("reboot"))
  hl.bind("R", hl.dsp.submap("reset"))
  hl.bind("R", hl.dsp.exec_cmd("pkill -RTMIN+9 waybar"))

  hl.bind("P", hl.dsp.exec_cmd("shutdown now"))
  hl.bind("P", hl.dsp.submap("reset"))
  hl.bind("P", hl.dsp.exec_cmd("pkill -RTMIN+9 waybar"))

  -- Tes Configs (On utilise ton chemin koda-floating-window)
  local float_nvim = "/home/nnovadev/.local/share/koda/bin/koda-floating-window kitty --class=nvim -e nvim "

  hl.bind("K", hl.dsp.exec_cmd(float_nvim .. "~/.local/share/koda/"))
  hl.bind("K", hl.dsp.submap("reset"))
  hl.bind("K", hl.dsp.exec_cmd("pkill -RTMIN+9 waybar"))

  hl.bind("H", hl.dsp.exec_cmd(float_nvim .. "~/.config/hypr"))
  hl.bind("H", hl.dsp.submap("reset"))
  hl.bind("H", hl.dsp.exec_cmd("pkill -RTMIN+9 waybar"))

  hl.bind("N", hl.dsp.exec_cmd(float_nvim .. "~/.config/nvim"))
  hl.bind("N", hl.dsp.submap("reset"))
  hl.bind("N", hl.dsp.exec_cmd("pkill -RTMIN+9 waybar"))

  hl.bind("Z", hl.dsp.exec_cmd(float_nvim .. "~/.zshrc"))
  hl.bind("Z", hl.dsp.submap("reset"))
  hl.bind("Z", hl.dsp.exec_cmd("pkill -RTMIN+9 waybar"))

  hl.bind("W", hl.dsp.exec_cmd(float_nvim .. "~/.config/waybar"))
  hl.bind("W", hl.dsp.submap("reset"))
  hl.bind("W", hl.dsp.exec_cmd("pkill -RTMIN+9 waybar"))

  -- Exit submap
  hl.bind("catchall", hl.dsp.submap("reset"))
  hl.bind("Escape", hl.dsp.submap("reset"))
  hl.bind("Escape", hl.dsp.exec_cmd("pkill -RTMIN+9 waybar"))
end)

-- Entrée dans le menu Media
hl.bind(base.mod .. " + M", hl.dsp.submap("󰋋"))
hl.define_submap("󰋋", function()

  hl.bind("I", hl.dsp.exec_cmd("playerctl previous"))
  hl.bind("O", hl.dsp.exec_cmd("playerctl --player=spotify play-pause"))
  hl.bind("P", hl.dsp.exec_cmd("playerctl next"))

  -- Lancer Spotify et reset
  hl.bind("M", hl.dsp.exec_cmd(apps.music))
  hl.bind("M", hl.dsp.submap("reset"))
  hl.bind("M", hl.dsp.exec_cmd("pkill -RTMIN+9 waybar"))

  hl.bind("Escape", hl.dsp.submap("reset"))
  hl.bind("Escape", hl.dsp.exec_cmd("pkill -RTMIN+9 waybar"))
end)


hl.bind(base.mod .. " + R", hl.dsp.submap("󰩨"))
hl.define_submap("󰩨", function()

    -- Set repeating binds for resizing the active window.
    hl.bind("L", hl.dsp.window.resize({ x = 100, y = 0, relative = true}), { repeating = true })
    hl.bind("H", hl.dsp.window.resize({ x = -100, y = 0, relative = true}), { repeating = true })
    hl.bind("J", hl.dsp.window.resize({ x = 0, y = 100, relative = true}), { repeating = true })
    hl.bind("K", hl.dsp.window.resize({ x = 0, y = -100, relative = true}), { repeating = true })

    -- Use `reset` to go back to the global submap
    hl.bind("escape", hl.dsp.submap("reset"))

end)
