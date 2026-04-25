return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      window = {
        width = 30,
        mappings = {
          -- Navigation style Vim (LazyVim)
          ["l"] = "open",
          ["h"] = "close_node",

          -- Désactive l'espace qui est par défaut assigné à autre chose,
          -- pour éviter les conflits si ton <leader> est la touche Espace
          ["<space>"] = "none",
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    })

    vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>", { desc = "Toggle File Explorer" })
  end,
}
