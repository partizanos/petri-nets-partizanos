local Petrinet = {}

Petrinet.Place      = {}
Petrinet.Transition = {}
Petrinet.Arc        = {}

Petrinet           .__index = Petrinet
Petrinet.Place     .__index = Petrinet.Place
Petrinet.Transition.__index = Petrinet.Transition
Petrinet.Arc       .__index = Petrinet.Arc

function Petrinet.create ()
  return setmetatable ({}, Petrinet)
end

function Petrinet.place (petrinet, marking)
  assert (getmetatable (petrinet) == Petrinet)
  assert (marking == nil or (type (marking) == "number" and marking >= 0))
  return setmetatable ({
    marking = marking or 0,
  }, Petrinet.Place)
end

function Petrinet.Place.__sub (place, valuation)
  assert (getmetatable (place) == Petrinet.Place)
  assert (type (valuation) == "number")
  assert (valuation > 0)
  return setmetatable ({
    type      = "pre",
    place     = place,
    valuation = valuation,
  }, Petrinet.Arc)
end

function Petrinet.Place.__add (place, valuation)
  assert (getmetatable (place) == Petrinet.Place)
  assert (type (valuation) == "number")
  assert (valuation > 0)
  return setmetatable ({
    type      = "post",
    place     = place,
    valuation = valuation,
  }, Petrinet.Arc)
end

function Petrinet.transition (petrinet, t)
  assert (getmetatable (petrinet) == Petrinet)
  assert (type (t) == "table")
  local result = setmetatable ({}, Petrinet.Transition)
  for k, v in pairs (t) do
    assert (getmetatable (v) == Petrinet.Arc)
    result [k] = v
  end
  return result
end

function Petrinet.places (petrinet)
  assert (getmetatable (petrinet) == Petrinet)
  return coroutine.wrap (function ()
    for k, v in pairs (petrinet) do
      if getmetatable (v) == Petrinet.Place then
        coroutine.yield (k, v)
      end
    end
  end)
end

function Petrinet.transitions (petrinet)
  assert (getmetatable (petrinet) == Petrinet)
  return coroutine.wrap (function ()
    for k, v in pairs (petrinet) do
      if getmetatable (v) == Petrinet.Transition then
        coroutine.yield (k, v)
      end
    end
  end)
end

function Petrinet.Transition.pre (transition)
  assert (getmetatable (transition) == Petrinet.Transition)
  return coroutine.wrap (function ()
    for k, v in pairs (transition) do
      if getmetatable (v) == Petrinet.Arc and v.type == "pre" then
        coroutine.yield (k, v)
      end
    end
  end)
end

function Petrinet.Transition.post (transition)
  assert (getmetatable (transition) == Petrinet.Transition)
  return coroutine.wrap (function ()
    for k, v in pairs (transition) do
      if getmetatable (v) == Petrinet.Arc and v.type == "post" then
        coroutine.yield (k, v)
      end
    end
  end)
end

return Petrinet
