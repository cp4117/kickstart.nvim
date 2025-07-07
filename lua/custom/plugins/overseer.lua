-- overseer
-- can run async tasks such as make etc. and output results to quickfix window

return {
  'stevearc/overseer.nvim',
  opts = {},
  config = function()
    local overseer = require 'overseer'
    overseer.setup {
      task_list = {
        default_detail = 1,
        min_height = 15,
      },
      component_aliases = {
        default = {
          'unique',
          'on_output_summarize',
          'on_exit_set_status',
          'on_complete_notify',
          'on_complete_dispose',
          { 'display_duration', detail_level = 1 },
          { 'on_output_quickfix', open_on_exit = 'failure', close = true, items_only = true },
          { 'on_result_diagnostics', remove_on_restart = true },
          { 'on_result_diagnostics_quickfix', set_empty_results = true },
        },
      },
    }

    local runTask = function()
      overseer.run_template({ cwd = vim.loop.cwd() }, function(task)
        if task then
          vim.cmd 'ccl'
          overseer.toggle()
          task:subscribe('on_complete', function()
            overseer.toggle()
          end)
        end
      end)
    end

    vim.keymap.set('n', '<leader>tr', runTask, { desc = '[R]un task' })
    vim.keymap.set('n', '<leader>tt', overseer.toggle, { desc = '[T]oggle overseer' })
  end,
}
