-- strike through, bold, and italic shortcuts
vim.keymap.set('v', '<localleader>s', 'c~~<c-r>"~~', { buffer = 0 })
vim.keymap.set('v', '<localleader>b', 'c**<c-r>"**', { buffer = 0 })
vim.keymap.set('v', '<localleader>i', 'c_<c-r>"_', { buffer = 0 })

vim.keymap.set('n', '<localleader>s', 'viwc~~<c-r>"~~<esc>', { buffer = 0 })
vim.keymap.set('n', '<localleader>b', 'viwc**<c-r>"**<esc>', { buffer = 0 })
vim.keymap.set('n', '<localleader>i', 'viwc_<c-r>"_<esc>', { buffer = 0 })

-- urls and titles
vim.keymap.set('v', '<localleader>t', 'c[<c-r>"]()<left>', { buffer = 0 })
vim.keymap.set('v', '<localleader>u', 'c[](<c-r>")<c-o>F]', { buffer = 0 })

vim.keymap.set('n', '<localleader>t', 'viwc[<c-r>"]()<left>', { buffer = 0 })
vim.keymap.set('n', '<localleader>u', 'viwc[](<c-r>")<c-o>F]', { buffer = 0 })

-- wrap in backticks
vim.keymap.set('v', '<localleader>`', 'c`<c-r>"`', { buffer = 0 })
vim.keymap.set('n', '<localleader>`', 'viwc`<c-r>"`<esc>', { buffer = 0 })
