-- see `:h lspconfig-all` for available servers and their settings
local lsp_servers = {
	lua_ls = {
		-- https://luals.github.io/wiki/settings/ | `:h nvim_get_runtime_file`
		Lua = { workspace = { library = vim.api.nvim_get_runtime_file("lua", true) }, },
	},

	-- TypeScript / JavaScript via vtsls
	vtsls = {},

	-- Java LSP (jdtls)
	-- NOTE: Mason only installs jdtls; this entry actually hooks it into Neovim.
	jdtls = {},
}

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
  ensure_installed = vim.tbl_keys(lsp_servers),
})

-- configure each lsp server on the table
-- to check what clients are attached to the current buffer, use
-- `:checkhealth vim.lsp`. to view default lsp keybindings, use `:h lsp-defaults`.
for server, config in pairs(lsp_servers) do
	vim.lsp.config(server, {
		settings = config,

		-- only create the keymaps if the server attaches successfully
		on_attach = function(_, bufnr)
			vim.keymap.set("n", "grd", vim.lsp.buf.definition,
				{ buffer = bufnr, desc = "vim.lsp.buf.definition()", })

			vim.keymap.set("n", "grf", vim.lsp.buf.format,
				{ buffer = bufnr, desc = "vim.lsp.buf.format()", })
		end,
	})

	-- enable filetype-based autostart for this server
	vim.lsp.enable(server)
end
