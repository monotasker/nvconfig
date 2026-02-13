-- Plugin: mfussenegger/nvim-dap
-- Installed via store.nvim

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "mfussenegger/nvim-dap-python",
  },
  config = function()
    local dap = require("dap")
    local ui = require("dapui")
    local dap_python = require("dap-python")

    ui.setup()
    require("nvim-dap-virtual-text").setup({
      commented = true,
    })
    -- Use project venv when VIRTUAL_ENV is set, else kcworks-nlp-tools .venv
    local venv = vim.fn.getenv("VIRTUAL_ENV")
    local py = (venv ~= "" and venv ~= vim.NIL) and (venv .. "/bin/python")
        or "/Users/ianscott/Development/kcworks-nlp-tools/.venv/bin/python"
    dap_python.setup(py)

    vim.fn.sign_define("DapBreakpoint", {
      text = "",
      texthl = "DiagnosticSignError",
      linehl = "",
      numhl = "",
    })

    vim.fn.sign_define("DapBreakpointRejected", {
      text = "", -- or "❌"
      texthl = "DiagnosticSignError",
      linehl = "",
      numhl = "",
    })

    vim.fn.sign_define("DapStopped", {
      text = "", -- or "→"
      texthl = "DiagnosticSignWarn",
      linehl = "Visual",
      numhl = "DiagnosticSignWarn",
    })

    -- Automatically open/close DAP UI
    dap.listeners.after.event_initialized["dapui_config"] = function()
      ui.open()
    end

    local opts = { noremap = true, silent = true }

    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, opts)
    vim.keymap.set("n", "<leader>gb", dap.run_to_cursor, opts)

    -- Eval symbol under cursor
    vim.keymap.set("n", "<leader>cv", function()
      require("dapui").eval(nil, { enter = true })
    end, opts)

    vim.keymap.set("n", "<leader>dc", dap.continue, opts)
    vim.keymap.set("n", "<leader>di", dap.step_into, opts)
    vim.keymap.set("n", "<leader>do", dap.step_over, opts)
    vim.keymap.set("n", "<leader>dO", dap.step_out, opts)
    vim.keymap.set("n", "<leader>dB", dap.step_back, opts)
    vim.keymap.set("n", "<F12>", dap.restart, opts)
    vim.keymap.set("n", "<leader>dq", dap.terminate, opts)
    vim.keymap.set("n", "<leader>du", ui.toggle, opts)

    dap.listeners.before.attach.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      ui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      ui.close()
    end
  end,
  event = "VeryLazy",
}
