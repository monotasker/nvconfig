-- Plugin: Shatur/neovim-session-manager
-- Installed via store.nvim

return {
    "Shatur/neovim-session-manager",
    config = function()
        local Path = require('plenary.path')
        require('session_manager').setup({
            sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'),
            path_replacer = '__',
            colon_replacer = '++',
            autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
            autosave_last_session = true,
            autosave_ignore_not_normal = true,
            autosave_ignore_dirs = {
                '~/',
                '~/Projects',
                '~/Downloads',
                '/',
            },
            autosave_ignore_filetypes = {
                'gitcommit',
                'gitrebase',
            },
            autosave_ignore_buftypes = {},
            autosave_only_in_session = false,
            max_path_length = 80,
        })

        -- Enable window geometry saving in session options
        vim.opt.sessionoptions:append('winpos')
        vim.opt.sessionoptions:append('winsize')
    end,
}
