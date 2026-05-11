---------------------
---- KEYBINDINGS ----
---------------------

local M = require("modules.vars")
local apps = M.apps
local scripts = M.scripts
local base = M.bases

-- Run Applications
hl.bind(base.mod .. " + Return", hl.dsp.exec_cmd(apps.terminal), { submap_universal = true })
hl.bind(base.mod .. " + B", hl.dsp.exec_cmd(apps.browser))
hl.bind(base.mod .. " + E", hl.dsp.exec_cmd(apps.fileManager))
hl.bind(base.mod .. " + T", hl.dsp.exec_cmd(scripts.launchTypst))
hl.bind(base.mod .. " + A", hl.dsp.exec_cmd(scripts.launchGemini))
hl.bind(base.mod .. " + Z", hl.dsp.exec_cmd(apps.discord))
hl.bind(base.mod .. " + K", hl.dsp.exec_cmd(scripts.launchKodaVm))

-- Menu
hl.bind(base.mod .. " + CTRL + Space", hl.dsp.exec_cmd(scripts.changeWallpaper))
hl.bind(base.mod .. " + D", hl.dsp.exec_cmd(apps.menu))

-- Control Tiling

hl.bind(base.mod .. " + W", hl.dsp.window.close())
hl.bind(base.mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(base.mod .. " + P", hl.dsp.window.pseudo())
hl.bind(base.mod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only
-- hl.bind(base.mod .. " + Backspace", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

-- Move/resize windows with base.mod + LMB/RMB and dragging
hl.bind(base.mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(base.mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Move focus
hl.bind(base.mod .. " + ALT + H", hl.dsp.focus({ direction = "left" }))
hl.bind(base.mod .. " + ALT + L", hl.dsp.focus({ direction = "right" }))
hl.bind(base.mod .. " + ALT + K", hl.dsp.focus({ direction = "up" }))
hl.bind(base.mod .. " + ALT + J", hl.dsp.focus({ direction = "down" }))

-- Fullscreen
hl.bind(base.mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(base.mod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(base.mod .. " + CTRL + F", hl.dsp.window.fullscreen_state({ internal = 0, client = 2, action = "toggle"}))

-- Captures
hl.bind("Print", hl.dsp.exec_cmd(scripts.screenshot))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("grim $HOME/Pictures/Screenshots/full_$(date +%Y%m%d_%H%M%S).png && notify-send 'Écran capturé'"))
hl.bind(base.mod .. " + Print", hl.dsp.exec_cmd("pkill hyprpicker || hyprpicker -a"))

-- Utils
hl.bind(base.mod .. " + SHIFT + Space", hl.dsp.exec_cmd(scripts.toggleWaybar))

-- Switch workspaces with base.mod + [0-9]
-- Move active window to a workspace with base.mod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(base.mod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(base.mod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
    hl.bind(base.mod .. " + ALT + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Swap active window with the one next to it with SUPER + SHIFT + arrow keys
hl.bind(base.mod .. " + SHIFT + LEFT",  hl.dsp.window.swap({ direction = "l" }))
hl.bind(base.mod .. " + SHIFT + RIGHT", hl.dsp.window.swap({ direction = "r" }))
hl.bind(base.mod .. " + SHIFT + UP",    hl.dsp.window.swap({ direction = "u" }))
hl.bind(base.mod .. " + SHIFT + DOWN",  hl.dsp.window.swap({ direction = "d" }))

-- Example special workspace (scratchpad)
hl.bind(base.mod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(base.mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
