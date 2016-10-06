local Fun      = require "fun"
local Petrinet = require "petrinet"
local State    = require "state"

local Graph   = {}
Graph.__index = Graph

function Graph.create (t)
  assert (type (t) == "table")
  assert (type (t.omegize  ) == "function")
  assert (type (t.traversal) == "function")
  return setmetatable ({
    omegize   = t.omegize,
    traversal = t.traversal,
  }, Graph)
end

function Graph.depth_first (work)
  local result = work [#work]
  work [#work] = nil
  return result
end

function Graph.breadth_first (work)
  local result = work [1]
  table.remove (work, 1)
  return result
end

function Graph.__call (graph, petrinet)
  assert (getmetatable (petrinet) == Petrinet)
  local initial = State.create (petrinet)
  local work    = { initial }
  local states  = { initial }
  while #work ~= 0 do
    local state = graph.traversal (work)
    -- TODO: implement graph generation algorithm
  end
  return initial, states
end

return Graph
