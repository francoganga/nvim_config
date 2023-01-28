local M = {}

M.close_all = function()
  require('close_buffers').wipe({ type = 'other', force = true })
  vim.cmd("silent only")
  vim.cmd("silent tabonly")
  -- vim.api.nvim_cmd({"tabonly"}, { output = false })
end

return M
