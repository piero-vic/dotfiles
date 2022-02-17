local sources = {
  "user.options",
  "user.keymaps",
  "user.plugins",
  "user.colorscheme",
  "user.lsp",
  "user.cmp",
  "user.treesitter",
  "user.comment",
  "user.telescope"
}

for _, source in ipairs(sources) do
  local status_ok, fault = pcall(require, source)
  if not status_ok then
    error("Failed to load " .. source .. "\n\n" .. fault)
  end
end
