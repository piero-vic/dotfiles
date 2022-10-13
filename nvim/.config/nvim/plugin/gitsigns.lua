-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║ Gitsigns                                                                  ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

require('gitsigns').setup {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or { noremap = true, silent = true }
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
  end,
}
