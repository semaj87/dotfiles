return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.config").setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    -- only install parsers that aren't already installed
    vim.schedule(function()
      local installed = require("nvim-treesitter.config").get_installed("parsers")
      local installed_set = {}
      for _, p in ipairs(installed) do
        installed_set[p] = true
      end

      local parsers = {
        "json", "javascript", "typescript", "tsx", "yaml", "html", "css",
        "prisma", "markdown", "markdown_inline", "svelte", "graphql", "bash",
        "lua", "vim", "dockerfile", "gitignore", "query", "vimdoc", "c",
      }
      for _, parser in ipairs(parsers) do
        if not installed_set[parser] then
          vim.cmd("TSInstall " .. parser)
        end
      end
    end)

    -- enable highlight and indent via vim.treesitter (built-in)
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })

    -- use bash parser for zsh files
    vim.treesitter.language.register("bash", "zsh")
  end,
}
