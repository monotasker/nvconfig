local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmta = require("luasnip.extras.fmt").fmta

return {
  s("header-dep", {
    t({
      "# Part of invenio-modular-deposit-form",
      "# Copyright (C) 2023-2026, MESH Research",
      "#",
      "# Invenio-Modular-Deposit-Form is free software; you can redistribute it and/or modify it",
      "# under the terms of the MIT License; see LICENSE file for more details.",
    }),
    i(0),
  }),
  s(
    "header",
    fmta(
      [[
      # Part of <package>
      # Copyright (C) 2023-2026, MESH Research
      #
      # <package> is free software; you can redistribute and/or modify it
      # under the terms of the MIT License; see LICENSE file for more details./n<final>
      ]],
      {
        package = i(1, "package"),
        final = i(0),
      },
      {
        repeat_duplicates = true,
      }
    )
  ),
}
