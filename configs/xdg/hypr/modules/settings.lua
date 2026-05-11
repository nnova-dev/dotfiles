-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

local envs = {
  -- Cursor size
  XCURSOR_SIZE = "24",
  HYPRCURSOR_SIZE = "24",

  -- Toolkit Backend
  GDK_BACKEND = "wayland,x11,*",
  QT_QPA_PLATFORM = "wayland;xcb",
  SDL_VIDEODRIVER = "wayland",

  -- XDG
  XDG_CURRENT_DESKTOP = "Hyprland",
  XDG_SESSION_DESKTOP = "Hyprland",
  XDG_SESSION_TYPE = "wayland",

  -- Qt
  QT_AUTO_SCREEN_SCALE_FACTOR = "1",
  QT_WAYLAND_DISABLE_WINDOWDECORATION = "1",
  QT_QPA_PLATFORMTHEME = "qt6ct",

  -- A voir
  QT_STYLE_OVERRIDE = "kvantum",
  MOZ_ENABLE_WAYLAND = "1",
  ELECTRON_OZONE_PLATFORM_HINT = "wayland",
  OZONE_PLATFORM = "wayland",
}

-- Application des variables
for key, value in pairs(envs) do
    hl.env(key, value)
end
