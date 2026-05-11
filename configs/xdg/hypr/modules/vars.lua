---------------------
-------- VARS -------
---------------------

---@diagnostic disable: unused-local
local M = {}
M.bases = {
  mod = "SUPER",
  hyper = "SUPER CTRL ALT SHIFT"
}

M.apps = {
  terminal = "kitty",
  fileManager = "thunar",
  menu = "wofi --show drun",
  browser = "firefox-developer-edition",
  secBrowser = "helium-browser",
  music = "spotify",
  discord = "discord"
}

M.scripts = {
  changeWallpaper = "~/.local/share/koda/bin/koda-wallpaper",
  initWallpaper = "~/.local/share/koda/bin/koda-inti-wallpaper",
  screenshot = "~/.local/share/koda/bin/koda-screenshot",
  toggleWaybar = "~/.local/share/koda/bin/koda-toggle-waybar",
  launchKodaVm = "~/.local/share/koda/bin/koda-window-vm",
  launchTypst = "~/.local/share/koda/bin/koda-launch-webapp https://typst.app",
  launchGemini = "~/.local/share/koda/bin/koda-launch-webapp https://gemini.google.com",
}

M.colors = {
  darkRed = "rgb(770000)",
  activeBorder = "rgba(ffffffff)",
  inactiveBorder = "rgba(595959aa)"
}

return M
