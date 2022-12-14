------------------------------------------
--      Sammy Neovim Configuration      --
------------------------------------------
-- Some configuration from https://github.com/Olical/magic-kit --

-- Make some modules easier to access.
local execute = vim.api.nvim_command
local fn = vim.fn
local fmt = string.format

-- Work out where our plugins will be stored.
local pack_path = fn.stdpath("data") .. "/site/pack"

function ensure (user, repo)
  -- Ensures a given github.com/USER/REPO is cloned in the pack/packer/start directory.
  local install_path = fmt("%s/packer/start/%s", pack_path, repo, repo)
  if fn.empty(fn.glob(install_path)) > 0 then
    execute(fmt("!git clone https://github.com/%s/%s %s", user, repo, install_path))
    execute(fmt("packadd %s", repo))
  end
end

-- Packer is our plugin manager.
ensure("wbthomason", "packer.nvim")

-- Aniseed compiles our Fennel code to Lua and loads it automatically.
ensure("Olical", "aniseed")

-- Impatient makes startup faster
ensure("lewis6991", "impatient.nvim")
require("impatient")

-- Enable Aniseed's automatic compilation and loading of Fennel source code.
-- Aniseed looks for this when it's loaded then loads the rest of your
-- configuration if it's set.
--
-- Check for vscode, and if found load a much shorter config
if vim.g.vscode then
    vim.g["aniseed#env"] = {
      module = "code.init",}
  else
    vim.g["aniseed#env"] = {
      module = "core.init",}
  end
