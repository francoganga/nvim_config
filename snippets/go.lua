local ls = require "luasnip"
local extras = require "luasnip.extras"
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local snippets = {
  s("p", fmt('fmt.Println("{}")', { i(1) })),
  s("pf", fmt('fmt.Printf("{}=%v\\n", {})', { i(1), extras.rep(1) })),
  s("e", fmt([[
  if err != nil {{
    {}
  }}
  ]], { i(1) })),
  s("append", fmt([[
  {} = append({}, {})
  ]], { i(1), extras.rep(1), i(2) }))
}

return snippets
