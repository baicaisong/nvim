local M = {}
function M.config()
    -- nvim-treesitter config
    require'nvim-treesitter.configs'.setup {
						require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = {"tsx"}
  },
  ensure_installed = {
    "graphql",
		"typescript",
		"python",
		"javascript",
		"jsonc",
		"yaml"
  },
}
}
end
return M
