local Fun      = require "fun"
local Petrinet = require "petrinet"
local Farkas   = require "invariant.farkas"

local Place = {}

function Place.create ()
  return setmetatable ({}, Place)
end

function Place.__call (invariant, petrinet)
  assert (getmetatable (invariant) == Place)
  assert (getmetatable (petrinet ) == Petrinet)
  local farkas = Farkas.create (petrinet)
  local data = {}
  Fun.each (function (place)
    local t = {}
    Fun.each (function (transition)
      Fun.each (function (pre)
        t [transition] = (t [transition] or 0) - pre.valuation
      end, Fun.filter (function (pre)
        return pre.place == place
      end, transition:pre ()))
      Fun.each (function (post)
        t [transition] = (t [transition] or 0) + post.valuation
      end, Fun.filter (function (post)
        return post.place == place
      end, transition:post ()))
    end, petrinet:transitions ())
    local entry = farkas:entry {
      [place] = 1,
    }
    data [entry] = t
  end, petrinet:places ())
  data = farkas (data)
  return Fun.map (function (key)
    return key
  end, Fun.frommap (data))
end

return Place
