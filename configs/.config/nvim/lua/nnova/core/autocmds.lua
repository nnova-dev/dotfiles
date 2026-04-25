-- 1. On crée une couleur personnalisée avec un fond forcé (bg)
vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#FFFFFF", fg = "NONE", default = false })

-- 2. On l'applique au yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("maconfig-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({
      higroup = "YankHighlight", -- On utilise notre couleur forcée
      timeout = 50,
    })
  end,
})

-- Désactive la continuation automatique des commentaires sur les nouvelles lignes
vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Désactive l'auto-commentaire",
  group = vim.api.nvim_create_augroup("maconfig-disable-autocomment", { clear = true }),
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})
