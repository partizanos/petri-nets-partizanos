local Fun      = require "fun"
local Petrinet = require "petrinet"

local Farkas = {}
local Entry  = {}
Farkas.__index = Farkas
Entry .__index = Entry

function Entry.__tostring (entry)
  assert (getmetatable (entry) == Entry)
  return table.concat (Fun.totable (Fun.map (function (key, value)
    return tostring (value) .. "*" .. tostring (entry.farkas.names [key])
  end, Fun.filter (function (key)
    return getmetatable (key) == Petrinet.Place
        or getmetatable (key) == Petrinet.Transition
  end, Fun.frommap (entry)))), " + ")
end

function Farkas.create (petrinet)
  assert (getmetatable (petrinet) == Petrinet)
  local names = Fun.tomap (Fun.map (function (key, value)
    if getmetatable (value) == Petrinet.Place
    or getmetatable (value) == Petrinet.Transition then
      return value, key
    end
  end, Fun.frommap (petrinet)))
  return setmetatable ({
    petrinet = petrinet,
    names    = names,
  }, Farkas)
end

function Farkas.entry (farkas, t)
  assert (getmetatable (farkas) == Farkas)
  assert (type (t) == "table")
  local result = setmetatable (Fun.tomap (Fun.frommap (t)), Entry)
  result.farkas = farkas
  return result
end

function Farkas.__call (farkas, matrix)
  assert (getmetatable (farkas) == Farkas)
  assert (type (matrix) == "table")
  -- TODO: implement Farkas algorithm
  return matrix
end

return Farkas
