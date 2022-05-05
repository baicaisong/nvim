local M = {}
function M.config()
    require('telescope').setup {
   defaults = {
    layout_config = {
      horizontal = {
	      preview_cutoff = 100,
	      preview_width = 0.5
      },
    },
  },
    }
end
return M
