return {
  "saghen/blink.cmp",
  -- optional: provides snippets for the snippet source
  dependencies = {
    "rafamadriz/friendly-snippets",
    "L3MON4D3/LuaSnip",
    -- "Kaiser-Yang/blink-cmp-avante",
    "saghen/blink.compat",
  },

  -- use a release tag to download pre-built binaries
  version = "1.*",
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = "enter",
      ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
    },
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
      documentation = {
        auto_show = false,
      },
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = {
        "lsp",
        "path",
        "snippets",
        "buffer",
        -- "avante_commands",
        -- "avante_mentions",
        -- "avante_shortcuts",
        -- "avante_files",
      },
      per_filetype = {
        codecompanion = { "codecompanion" },
        -- AvanteSelectedFiles = { "avante", "path", "buffer" },
        -- AvanteInput = { "avante", "path", "lsp", "buffer" },
      },
      providers = {
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp",
        },
        -- avante_commands = {
        --   name = "avante_commands",
        --   module = "blink.compat.source",
        --   score_offset = 90, -- show at a higher priority than lsp
        --   opts = {},
        -- },
        -- avante_files = {
        --   name = "avante_files",
        --   module = "blink.compat.source",
        --   score_offset = 100, -- show at a higher priority than lsp
        --   opts = {},
        -- },
        -- avante_mentions = {
        --   name = "avante_mentions",
        --   module = "blink.compat.source",
        --   score_offset = 1000, -- show at a higher priority than lsp
        --   opts = {},
        -- },
        -- avante_shortcuts = {
        --   name = "avante_shortcuts",
        --   module = "blink.compat.source",
        --   score_offset = 1000, -- show at a higher priority than lsp
        --   opts = {},
        -- },
      },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
