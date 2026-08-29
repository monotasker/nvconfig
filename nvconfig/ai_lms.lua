-- Shared LMS connection settings for Avante, Minuet, etc.
-- LMS: macOS → Tailscale host; Linux → localhost (port 1234)

local M = {}

local uname = vim.uv.os_uname()
local is_macos = uname.sysname == "Darwin"

-- Override with: export LMS_HOST=100.84.114.49  (optional)
M.host = vim.env.LMS_HOST or (is_macos and "100.84.114.49" or "127.0.0.1")
M.port = tonumber(vim.env.LMS_PORT) or 1234

M.base_url = ("http://%s:%d"):format(M.host, M.port)
M.v1 = M.base_url .. "/v1"

-- From: curl http://HOST:1234/v1/models
M.chat_model = "qwen/qwen3-coder-next"
M.fim_model = "qwen/qwen3-coder-next"

-- Tokens: Avante trims/compacts to this. LMS must load the model with the same
-- (or larger) context — e.g. lms load qwen/qwen3-coder-next --context-length 131072
M.context_tokens = tonumber(vim.env.LMS_CONTEXT) or 131072

return M
