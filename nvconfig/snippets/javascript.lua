local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmta = require("luasnip.extras.fmt").fmta

return {
  s("header-dep", {
    t({
      "// Part of invenio-modular-deposit-form",
      "// Copyright (C) 2023-2026, MESH Research",
      "//",
      "// Invenio-Modular-Deposit-Form is free software; you can redistribute it and/or modify it",
      "// under the terms of the MIT License; see LICENSE file for more details.",
    }),
    i(0),
  }),
  s("header-works", {
    t({
      "// Part of Knowledge Commons Works",
      "// Copyright (C) 2023-2026, MESH Research",
      "//",
      "// Knowledge Commons Works is an instance of InvenioRDM, which is",
      "// Copyright (c) 20??-2026, CERN",
      "// ",
      "// Knowledge Commons Works and InvenioRDM are both free software; ",
      "// You can redistribute and/or modify them under the terms of the ",
      "// MIT License; see LICENSE file for more details.",
    }),
    i(0),
  }),
  s(
    "header",
    fmta(
      [[
      // Part of <package>
      // Copyright (C) 2023-2026, MESH Research
      //
      // <package> is free software; you can redistribute and/or modify it
      // under the terms of the MIT License; see LICENSE file for more details.
      ]],
      {
        package = i(1, "package"),
      }
    )
  ),
}
