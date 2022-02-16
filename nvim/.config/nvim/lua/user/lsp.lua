local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local servers = {
  "bashls",
  "emmet_ls",
  "pyright",
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

lsp_installer.on_server_ready(function(server)
    local opts = {}
    server:setup(opts)
end)
