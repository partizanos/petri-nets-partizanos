local Fun     = require "fun"
local Graph   = require "graph"
local Marking = require "marking"

local Coverability = {}

function Coverability.create (t)
  t = t or {
    traversal = Graph.depth_first,
  }
  assert (type (t) == "table")
  assert (type (t.traversal) == "function")
  return Graph.create {
    traversal = t.traversal,
    omegize   = function (x)
      -- TODO: omegize `x.current`
    end,
  }
end

return Coverability
