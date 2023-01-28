local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local close_buffers = require('close_buffers')

local M = {}

M.fuzzy_dirs = function(opts)
  opts = opts or {}

  -- vim.fn.jobstart({"find", ".", "-type", "d", "|", "grep", "-vE", "git"}, {
  vim.fn.jobstart({ "find", ".", "-type", "d" }, {
    stdout_buffered = true,
    on_stdout = function(_, data)

      local d = data

      local filtered = {}

      --FILTER git?
      for _, dir in ipairs(d) do
        if dir == "." then
        else if string.find(dir, "git") == nil then
            table.insert(filtered, dir)
          end
        end
      end


      pickers.new(opts, {
        prompt_title = "colors",
        finder = finders.new_table {
          results = filtered
        },
        sorter = conf.generic_sorter(opts),

        attach_mappings = function(prompt_bufnr, _)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            vim.cmd(string.format("silent edit %s", selection[1]))
          end)
          return true
        end,

      }):find()




    end
  })
end

M.close_all = function()
  close_buffers.wipe({ type = 'other', force = true })
  vim.cmd("silent only")
  vim.cmd("silent tabonly")
  -- vim.api.nvim_cmd({"tabonly"}, { output = false })
end

return M
