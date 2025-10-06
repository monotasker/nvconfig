return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "mason-org/mason-lspconfig.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local navic = require("nvim-navic")

    -- Common LSP settings
    local on_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
    end
    -- LSP keybindings are now centralized in remap.lua
    -- end

    -- Get capabilities from nvim-cmp
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Server-specific configurations
    local servers = {
      -- Python
      pylsp = {
        settings = {
          pylsp = {
            plugins = {
              -- Disable built-in linting (we use ruff)
              pycodestyle = { enabled = false },
              mccabe = { enabled = false },
              pyflakes = { enabled = false },
              flake8 = { enabled = false },
              -- Enable mypy for type checking
              pylsp_mypy = { enabled = true },
              -- Keep useful LSP features
              rope_completion = { enabled = true },
              rope_autoimport = { enabled = true },
              jedi_completion = { enabled = true, fuzzy = true },
              jedi_hover = { enabled = true },
              jedi_references = { enabled = true },
              jedi_signature_help = { enabled = true },
              jedi_symbols = { enabled = true },
              -- Ensure symbol support is enabled
              jedi_definition = { enabled = true },
              jedi_implementation = { enabled = true },
            },
            jedi = {
              environment = vim.fn.getenv('VIRTUAL_ENV'),
            },
          },
        },
      },

      ruff_lsp = {
        init_options = {
          settings = {
            args = {},
          },
        },
      },

      -- JavaScript/TypeScript/React
      tsserver = {
        settings = {
          typescript = {
            preferences = {
              disableSuggestions = false,
              includePackageJsonAutoImports = "auto",
            },
          },
          javascript = {
            preferences = {
              disableSuggestions = false,
              includePackageJsonAutoImports = "auto",
            },
          },
          completions = {
            completeFunctionCalls = true,
          },
        },
      },

      eslint = {
        settings = {
          codeActionOnSave = {
            enable = true,
            mode = "all",
          },
          format = true,
        },
      },

      -- Web technologies
      html = {
        settings = {
          html = {
            format = {
              templating = true,
              wrapLineLength = 120,
              wrapAttributes = "auto",
            },
            suggest = {
              html5 = true,
            },
          },
        },
      },

      cssls = {
        settings = {
          css = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
            },
          },
          less = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
            },
          },
          scss = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
            },
          },
        },
      },

      jsonls = {
        settings = {
          json = {
            schemas = {
              {
                fileMatch = { "package.json" },
                url = "https://json.schemastore.org/package.json",
              },
              {
                fileMatch = { "tsconfig*.json" },
                url = "https://json.schemastore.org/tsconfig.json",
              },
            },
            validate = { enable = true },
          },
        },
      },

      emmet_ls = {
        settings = {
          emmet = {
            includeLanguages = {
              ["html-jinja"] = "html",
              ["jinja-html"] = "html",
            },
            variables = {},
            preferences = {},
            showExpandedAbbreviation = "always",
            showAbbreviationSuggestions = true,
            syntaxProfiles = {},
            excludeLanguages = {},
            extensionsPath = {},
            format = {
              enabled = true,
              indent = {
                block = "    ",
                inline = "  ",
                script = "  ",
                style = "  ",
              },
              wrap = "auto",
              wrapLineLength = 120,
              wrapAttributes = "auto",
              wrapAttributesIndentSize = 2,
              preserveNewLines = true,
              maxPreserveNewLines = 2,
              unformatted = "",
              contentUnformatted = "pre,code,textarea",
              indentInnerHtml = false,
              extraLiners = "head,body,/html",
            },
          },
        },
      },

      -- CSS preprocessors
      less_ls = {
        settings = {
          less = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
            },
          },
        },
      },

      scss_ls = {
        settings = {
          scss = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
            },
          },
        },
      },

      -- Data formats
      yamlls = {
        settings = {
          yaml = {
            schemas = {
              {
                fileMatch = { "docker-compose*.yml", "docker-compose*.yaml" },
                url = "https://json.schemastore.org/docker-compose.json",
              },
              {
                fileMatch = { "*.github/workflows/*.yml", "*.github/workflows/*.yaml" },
                url = "https://json.schemastore.org/github-workflow.json",
              },
            },
            validate = { enable = true },
            format = { enable = true },
            hover = { enable = true },
            completion = { enable = true },
          },
        },
      },

      lemminx = {
        settings = {
          xml = {
            validation = {
              enabled = true,
              schema = true,
              noGrammar = "warning",
            },
            format = {
              enabled = true,
              splitAttributes = true,
              joinCDATALines = false,
              joinContentLines = false,
              joinCommentLines = false,
              formatXSI = true,
              preserveSpace = false,
              maxLineWidth = 120,
            },
            hover = {
              enabled = true,
            },
            completion = {
              enabled = true,
              autoCloseTags = true,
            },
          },
        },
      },

      -- Markup
      marksman = {
        settings = {
          markdown = {
            enable = true,
            suggest = {
              path = {
                enabled = true,
              },
              reference = {
                enabled = true,
              },
            },
            hover = {
              enabled = true,
            },
            completion = {
              enabled = true,
            },
          },
        },
      },

      -- Database & Query
      sqls = {
        settings = {
          sqls = {
            connections = {
              {
                driver = "postgres",
                dataSourceName = "host=127.0.0.1 port=5432 user=postgres password=postgres dbname=postgres sslmode=disable",
              },
            },
          },
        },
      },

      -- Infrastructure
      dockerls = {
        settings = {
          docker = {
            languageserver = {
              formatter = {
                ignoreMultilineInstructions = true,
              },
            },
          },
        },
      },

      nginx = {
        settings = {
          nginx = {
            root = "/etc/nginx",
            include = "/etc/nginx/conf.d/*.conf",
            cmd = { "nginx", "-t" },
          },
        },
      },

      -- Testing
      quick_lint_js = {
        settings = {
          quick_lint_js = {
            globals = { "jest", "describe", "it", "expect", "beforeEach", "afterEach", "beforeAll", "afterAll" },
          },
        },
      },

      -- Lua (for Neovim config)
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim", "require" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
          },
        },
      },
    }

    -- Setup LSP servers using the modern vim.lsp.config() API
    -- This is the new way since setup_handlers was deprecated in mason-lspconfig 2.0+

    -- Setup TypeScript/JavaScript server
    vim.lsp.config("tsserver", {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = servers.tsserver.settings,
    })

    -- Setup Python server
    vim.lsp.config("pylsp", {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = servers.pylsp.settings,
    })

    -- Setup Database & Query
    vim.lsp.config("sqls", {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = servers.sqls.settings,
    })

    -- Setup Infrastructure
    vim.lsp.config("dockerls", {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = servers.dockerls.settings,
    })

    vim.lsp.config("nginx", {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = servers.nginx.settings,
    })

    -- Setup Testing
    vim.lsp.config("quick_lint_js", {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = servers.quick_lint_js.settings,
    })

    -- Setup Lua server (for Neovim config)
    vim.lsp.config("lua_ls", {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = servers.lua_ls.settings,
    })

    -- Diagnostic configuration
    vim.diagnostic.config({
      virtual_text = {
        prefix = "●",
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    -- Diagnostic signs (modern API)
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = " ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
    })
  end,
}
