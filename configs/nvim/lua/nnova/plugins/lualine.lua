return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto", -- S'adapte automatiquement à ton colorscheme
        globalstatus = true, -- Une seule barre en bas, même avec plusieurs fenêtres
        component_separators = { left = "", right = "" }, -- Retire les chevrons inutiles
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diagnostics" },
        lualine_c = { { "filename", path = 1 } }, -- path = 1 affiche le chemin relatif
        lualine_x = { "filetype" },
        lualine_y = {}, -- On vide cette section
        lualine_z = { "location" }, -- Juste la position (ligne:colonne) à droite
      },
    })
  end,
}
