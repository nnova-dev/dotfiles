-- Désactive Netrw complètement pour éviter les conflits avec neo-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nnova.core.options")
require("nnova.core.keymaps")
require("nnova.core.autocmds")

vim.api.nvim_create_user_command('MavenNew', function()
  local name = vim.fn.input('Nom du projet : ')
  local group = vim.fn.input('Group ID (ex: com.tp6) : ')
  
  if name ~= "" and group ~= "" then
    -- On utilise l'archétype 1.4 qui est plus propre que le 1.0 par défaut
    local cmd = string.format(
      "mvn archetype:generate -DgroupId=%s -DartifactId=%s " ..
      "-DarchetypeArtifactId=maven-archetype-quickstart " ..
      "-DarchetypeVersion=1.4 -DinteractiveMode=false",
      group, name
    )
    
    -- Exécution de la création
    print("\nCréation du projet en cours...")
    vim.fn.system(cmd)
    
    -- On patche le pom.xml pour mettre JUnit 4.13.2 à la place de la version par défaut
    local pom_path = name .. "/pom.xml"
    local sed_cmd = "sed -i 's/4.11/4.13.2/g' " .. pom_path .. " 2>/dev/null || " ..
                    "sed -i '' 's/4.11/4.13.2/g' " .. pom_path -- Compatibilité Linux/Mac
    vim.fn.system(sed_cmd)
    
    print("Projet " .. name .. " créé avec JUnit 4.13.2 ! 🚀")
    -- Ouvre le dossier du projet dans l'explorateur Nvim
    vim.cmd("cd " .. name)
  else
    print("Annulé : Données manquantes.")
  end
end, {})
