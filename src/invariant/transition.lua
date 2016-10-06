local Fun      = require "fun"
local Petrinet = require "petrinet"
local Farkas   = require "invariant.farkas"

local Transition = {}

function Transition.create ()
  return setmetatable ({}, Transition)
end

function Transition.__call (invariant, petrinet)
  assert (getmetatable (invariant) == Transition)
  assert (getmetatable (petrinet ) == Petrinet)
  local farkas = Farkas.create (petrinet)
  local data = {}
  Fun.each (function (transition)
    local t = {}
    Fun.each (function (place)
      Fun.each (function (pre)
        t [place] = (t [place] or 0) - pre.valuation
      end, Fun.filter (function (pre)
        return pre.place == place
      end, transition:pre ()))
      Fun.each (function (post)
        t [place] = (t [place] or 0) + post.valuation
      end, Fun.filter (function (post)
        return post.place == place
      end, transition:post ()))
    end, petrinet:places ())
    local entry = farkas:entry {
      [transition] = 1,
    }
    data [entry] = t
  end, petrinet:transitions ())
  data = farkas (data)
  return Fun.map (function (key)
    return key
  end, Fun.frommap (data))
end

return Transition
