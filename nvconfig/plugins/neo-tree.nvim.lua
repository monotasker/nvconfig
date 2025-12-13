-- Plugin: nvim-neo-tree/neo-tree.nvim
-- Installed via store.nvim

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons", -- optional, but recommended
  },
  lazy = false, -- neo-tree will lazily load itself
  config = function()
    require("neo-tree").setup({
      close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
      popup_border_style = "NC", -- or "" to use 'winborder' on Neovim v0.11+

      -- Performance optimizations for large directories
      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
        use_libuv_file_watcher = true, -- Use libuv file watcher for better performance
        -- Disable git features that cause EMFILE errors
        git_status = {
          enable = false, -- Disable git status to prevent EMFILE errors
        },
        filtered_items = {
          visible = true, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = true,
          hide_gitignored = false, -- Disable git ignore checking to prevent EMFILE errors
          hide_hidden = true, -- only works on Windows for hidden files/directories
          hide_by_name = {
            -- Only hide truly unnecessary system/cache directories
            ".git",
            "__pycache__",
            ".pytest_cache",
            ".mypy_cache",
            ".ruff_cache",
            ".coverage",
            "build",
            "dist",
            "target",
            ".next",
            ".nuxt",
            "vendor",
            -- Keep all important development directories visible!
          },
          hide_by_pattern = { -- uses glob style patterns
            "**/.git",
            "**/__pycache__",
            "**/.pytest_cache",
            "**/.mypy_cache",
            "**/.ruff_cache",
            "**/build",
            "**/dist",
            "**/target",
          },
          never_show = { -- remains hidden even if visible is true
            ".DS_Store",
            "thumbs.db",
            ".git",
          },
        },
        -- Performance optimizations without hiding important directories
        scan_mode = "shallow", -- Only scan directories when opened
        bind_to_cwd = true,
        -- Add debounce to prevent rapid file system operations
        debounce_delay = 100, -- Increased delay to prevent EMFILE errors
        cwd_target = {
          sidebar = "tab", -- sidebar is when position = left or right
          current = "window", -- current is when position = current
        },

        commands = {
          -- avante_add_files = function(state)
          --   local node = state.tree:get_node()
          --   local filepath = node:get_id()
          --   local relative_path = require("avante.utils").relative_path(filepath)
          --
          --   local sidebar = require("avante").get()
          --
          --   local open = sidebar:is_open()
          --   -- ensure avante sidebar is open
          --   if not open then
          --     require("avante.api").ask()
          --     sidebar = require("avante").get()
          --   end
          --
          --   sidebar.file_selector:add_selected_file(relative_path)
          --
          --   -- remove neo tree buffer
          --   if not open then
          --     sidebar.file_selector:remove_selected_file("neo-tree filesystem [1]")
          --   end
          -- end,
        },
        window = {
          mappings = {
            -- ["oa"] = "avante_add_files",
          },
        },
      },

      -- Reduce memory usage
      default_component_configs = {
        git_status = {
          symbols = {
            -- Change type
            added = "A", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = "M", -- or "⬙", but this is redundant info if you use git_status_colors on the name
            deleted = "D", -- this can be a bit confusing, because the delete is not staged
            renamed = "R", -- this can be a bit confusing, because the rename is not staged
            -- Status type
            untracked = "U",
            ignored = "I",
            unstaged = "M",
            staged = "S",
            conflict = "C",
          },
        },
      },
    })
  end,
}
