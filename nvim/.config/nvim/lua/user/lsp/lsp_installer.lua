local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

-- Install servers
local servers = {
  "bashls",
  "emmet_ls",
  "jedi_language_server",
  "solargraph",
  "sumneko_lua",
  "tailwindcss",
  "tsserver",
  "vimls",
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print("Installing " .. name)
    server:install()
  end
end

-- Config LSP
lsp_installer.on_server_ready(function(server)
    local opts = server:get_default_options()

		opts.on_attach = require("user.lsp.handlers").on_attach
		opts.capabilities = require("user.lsp.handlers").capabilities

    -- Apply server settings if available
    local present, av_overrides = pcall(require, "user.lsp.server_settings." .. server.name)
    if present then
      opts = vim.tbl_deep_extend("force", av_overrides, opts)
    end

    server:setup(opts)
end)
