------------------
---- MONITORS ----
------------------

-- Écran secondaire (HDMI) au-dessus
hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@60",
    position = "0x0",
    scale = 1,
})

-- Laptop (eDP-1) en dessous
hl.monitor({
    output = "eDP-1",
    mode = "1920x1080@60",
    position = "0x1080",
    scale = 1,
})
