-- Simplesec helpers for kulala.nvim pre-request scripts.
-- Decrypts via `ssec get` on send.
--
-- Security notes:
--   * Does not set OS / vim.env variables.
--   * Does not write private.env files or client.global.
--   * Never logs ssec stdout/stderr (secret values travel only on the pipe
--     into Neovim memory, then into Kulala request.environment for {{VAR}}).
--   * vim.system({...}) execs argv directly — no shell — so values do not
--     appear in zsh/bash history. The secret *path* (not value) is in argv
--     and can show briefly in `ps`.
--   * Residual risk: Kulala verbose / copy-as-curl / the outbound HTTP
--     request itself still see substituted header values.
--
-- Usage:
--   require("nvconfig.kulala.simplesec").inject("KC_API_KEY")
--   require("nvconfig.kulala.simplesec").inject({ "KC_API_KEY", "KCWORKS_API_KEY" })
--   require("nvconfig.kulala.simplesec").inject_secrets()  -- all (N touches)
--   require("nvconfig.kulala.simplesec").inject_token()    -- legacy TOKEN

local M = {}

-- Safe, non-sensitive failure codes only (never ssec stdout/stderr).
local ERR = {
  failed = "ssec get failed",
  empty = "ssec get returned empty",
  no_secrets = "set secrets { VAR = \"path\", ... } in http-client.env.json",
  none = "no secrets to inject",
  unknown = "unknown secret key (not in env.secrets)",
  no_token = "set token_secret or secrets.TOKEN in http-client.env.json",
}

local function ssec_bin()
  local candidates = {
    vim.fn.expand("~/.local/bin/ssec"),
    vim.fn.expand("~/.local/bin/simplesec/simplesec.sh"),
    "ssec",
  }
  for _, path in ipairs(candidates) do
    if path == "ssec" or vim.fn.executable(path) == 1 then
      return path
    end
  end
  return "ssec"
end

--- Decrypt one secret.
--- On failure, err is a safe static code only — never subprocess output.
---@param name string pass entry path
---@param store? string simplesec store label
---@return string|nil value
---@return string|nil err_code
function M.get(name, store)
  store = store or "default"

  -- List-form argv: no shell, so nothing enters shell history.
  local r = vim.system(
    { ssec_bin(), "-s", store, "get", name },
    { text = true }
  ):wait()

  local code = r.code
  local stdout = r.stdout
  -- Drop references to stderr immediately; never return or log it.
  r.stderr = nil
  r.stdout = nil

  if code ~= 0 then
    stdout = nil
    return nil, ERR.failed
  end

  local value = (stdout or ""):match("^%s*(.-)%s*$")
  stdout = nil
  if value == "" then
    return nil, ERR.empty
  end
  return value, nil
end

local function env_of(req)
  return req.environment or req.variables or {}
end

local function normalize_vars(vars)
  if vars == nil then
    return nil
  end
  if type(vars) == "string" then
    return { vars }
  end
  if type(vars) == "table" then
    local list = {}
    local is_list = true
    for k, v in pairs(vars) do
      if type(k) ~= "number" then
        is_list = false
        break
      end
      list[#list + 1] = v
    end
    if is_list then
      return list
    end
    local keys = {}
    for k in pairs(vars) do
      keys[#keys + 1] = k
    end
    table.sort(keys)
    return keys
  end
  return nil
end

--- Log only static safe messages (may still appear in Kulala script output).
local function fail(req, cli, msg)
  if cli and cli.log then
    cli.log("simplesec: " .. msg)
  end
  req.skip()
end

--- Inject one or more named entries from env.secrets.
--- vars: string | string[] | nil (nil = every key in secrets)
---@param vars? string|string[]|table
---@param req? table
---@param cli? table
---@return boolean ok
function M.inject(vars, req, cli)
  req = req or request
  cli = cli or client
  local env = env_of(req)
  local store = env.simplesec_store or "default"
  local secrets = env.secrets

  if type(secrets) ~= "table" then
    fail(req, cli, ERR.no_secrets)
    return false
  end

  local names = normalize_vars(vars)
  if names == nil then
    names = {}
    for k, path in pairs(secrets) do
      if type(k) == "string" and type(path) == "string" and path ~= "" then
        names[#names + 1] = k
      end
    end
    table.sort(names)
  end

  if #names == 0 then
    fail(req, cli, ERR.none)
    return false
  end

  for _, var in ipairs(names) do
    local path = secrets[var]
    if type(path) ~= "string" or path == "" then
      fail(req, cli, ERR.unknown .. ": " .. tostring(var))
      return false
    end
    local value, err = M.get(path, store)
    if not value then
      -- Log var name + safe code only (not path contents from ssec, not value).
      fail(req, cli, tostring(var) .. ": " .. (err or ERR.failed))
      return false
    end
    env[var] = value
  end

  return true
end

--- Inject every entry in env.secrets (one touch per secret). Prefer inject("NAME").
---@param req? table
---@param cli? table
function M.inject_secrets(req, cli)
  M.inject(nil, req, cli)
end

--- Legacy: inject {{TOKEN}} from env.token_secret / simplesec_store.
---@param req? table
---@param cli? table
function M.inject_token(req, cli)
  req = req or request
  cli = cli or client
  local env = env_of(req)

  local name = env.token_secret
  if not name or name == "" then
    if type(env.secrets) == "table" and env.secrets.TOKEN then
      return M.inject("TOKEN", req, cli)
    end
    fail(req, cli, ERR.no_token)
    return
  end

  local store = env.simplesec_store or "default"
  local value, err = M.get(name, store)
  if not value then
    fail(req, cli, err or ERR.failed)
    return
  end

  env.TOKEN = value
end

return M
