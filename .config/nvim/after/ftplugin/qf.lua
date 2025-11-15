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
