vim.keymap.set('n', 'dd', function()
  local qf_list = vim.fn.getqflist()
  local current_line = vim.fn.line '.'

  if qf_list[current_line] then
    table.remove(qf_list, current_line)

    vim.fn.setqflist(qf_list, 'r')

    local new_line = math.min(current_line, #qf_list)
    vim.fn.cursor(new_line, 1)
  end
end, { buffer = 0 })

vim.keymap.set('x', 'd', function()
  local qf_list = vim.fn.getqflist()
  local start_line = vim.fn.getpos('v')[2]
  local end_line = vim.fn.getpos('.')[2]

  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  for _ = start_line, end_line do
    if qf_list[start_line] then
      table.remove(qf_list, start_line)
    end
  end

  vim.fn.setqflist(qf_list, 'r')

  local new_line = math.min(start_line, #qf_list)
  vim.fn.cursor(new_line, 1)

  local esc_key = vim.api.nvim_replace_termcodes('<Esc>', true, false, true)
  vim.api.nvim_feedkeys(esc_key, 'n', false)
end, { buffer = 0 })
