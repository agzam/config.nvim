-- set leader
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
                      }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

function recompile()
  -- Just delete and recompile without reloading
  vim.fn.delete(vim.fn.stdpath("config") .. "/lua", "rf")
  -- Change to config directory before compiling
  local original_cwd = vim.fn.getcwd()
  vim.cmd("cd " .. vim.fn.stdpath("config"))
  require('nfnl.api')['compile-all-files']()
  vim.cmd("cd " .. original_cwd)

  require("lazy").sync()
end
vim.cmd("command! Recompile lua recompile()")

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.fnl",
  callback = function()
    local original_cwd = vim.fn.getcwd()
    vim.cmd("cd " .. vim.fn.stdpath("config"))
    require('nfnl.api')['compile-all-files']()
    vim.cmd("cd " .. original_cwd)
  end
})

-- on first run, install lazy.nvim and compile plugins, otherwise just load plugins
if (vim.fn.isdirectory(vim.fn.stdpath("config") .. "/lua/plugins") == 0) then
  require("lazy").setup({ { "Olical/nfnl" } })
  recompile()
  print("Exit and restart neovim")
  -- wait for user input and exit
  vim.defer_fn(function()
      vim.cmd("qa")
  end, 1)
else
  require("lazy").setup({
      {
        "Olical/nfnl",
        ft = "fennel",
        dependencies = { "norcalli/nvim.lua" }
      },
      { import = "plugins" }
                       })

  require("config")
end

vim.loader.enable()
