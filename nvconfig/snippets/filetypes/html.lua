local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local year = require("nvconfig.snippets.utils").year

return {
  s(
    "header-works",
    fmta(
      [[
      {# -*- coding: utf-8 -*-

        This file is part of Knowledge Commons Works.
        Copyright (C) 2023-<year> Mesh Research.

        Knowledge Commons Works is free software; you can redistribute it and/or modify it
        under the terms of the MIT License; see LICENSE file for more details.
      #}
      <final>
      ]],
      {
        year = year(),
        final = i(0),
      },
      {
        repeat_duplicates = true,
      }
    )
  ),
  s(
    "header",
    fmta(
      [[
      {# -*- coding: utf-8 -*-

        This file is part of <package>.
        Copyright (C) 2023-<year> Mesh Research.

        <package> is free software; you can redistribute it and/or modify it
        under the terms of the MIT License; see LICENSE file for more details.
      #}
      <final>
      ]],
      {
        package = i(1, "package"),
        year = year(),
        final = i(0),
      },
      {
        repeat_duplicates = true,
      }
    )
  ),
}
