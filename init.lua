local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  print("nvim is bootstrapping.")
  local fn = vim.fn

  fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.runtimepath:prepend(lazypath)

function recompile()
    local cwd = vim.fn.getcwd()
    vim.cmd("cd " .. vim.fn.stdpath("config"))
    -- delete
    vim.fn.delete(vim.fn.stdpath("config") .. "/lua", "rf")
    require('nfnl.api')['compile-all-files']()
    vim.cmd("cd " .. cwd)

    vim.cmd("source " .. vim.fn.stdpath("config") .. "/init.lua")
end
vim.cmd("command! Recompile lua recompile()")

-- set leader
vim.g.mapleader = " "
vim.g.maplocalleader = ","

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
end
