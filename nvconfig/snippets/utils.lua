local partial = require("luasnip.extras").partial

local M = {}

--- Function node that inserts the current year at expansion time.
--- Returns a fresh node on each call so it can be reused across snippets safely.
---@return table LuaSnip function node
function M.year()
  return partial(os.date, "%Y")
end

return M
