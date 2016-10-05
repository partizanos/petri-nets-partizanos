local Petrinet = require "petrinet"
local Marking  = {}

function Marking.initial (petrinet)
  assert (getmetatable (petrinet) == Petrinet)
  local result = setmetatable ({}, Marking)
  for _, place in petrinet:places () do
    result [place] = place.marking
  end
  return result
end

function Marking.create (t)
  assert (type (t) == "table")
  local result = setmetatable ({}, Marking)
  for k, v in pairs (t) do
    assert (getmetatable (k) == Petrinet.Place)
    assert (type (v) == "number")
    assert (v >= 0)
    result [k] = v
  end
  return result
end

function Marking.__eq (lhs, rhs)
  assert (getmetatable (lhs) == Marking)
  assert (getmetatable (rhs) == Marking)
  for k, v in pairs (lhs) do
    if rhs [k] ~= v then
      return false
    end
  end
  for k, v in pairs (rhs) do
    if lhs [k] ~= v then
      return false
    end
  end
  return true
end

function Marking.__le (lhs, rhs)
  assert (getmetatable (lhs) == Marking)
  assert (getmetatable (rhs) == Marking)
  for k, v in pairs (lhs) do
    if not rhs [k] or v > rhs [k] then
      return false
    end
  end
  return true
end

function Marking.__lt (lhs, rhs)
  assert (getmetatable (lhs) == Marking)
  assert (getmetatable (rhs) == Marking)
  for k, v in pairs (lhs) do
    if not rhs [k] or v > rhs [k] then
      return false
    end
  end
  return lhs ~= rhs
end

function Marking.__add (lhs, rhs)
  local data = {}
  for k, v in pairs (lhs) do
    data [k] = v
  end
  for k, v in pairs (rhs) do
    data [k] = (data [k] or 0) + v
  end
  return Marking.create (data)
end

function Marking.__sub (lhs, rhs)
  local data = {}
  for k, v in pairs (lhs) do
    data [k] = v
  end
  for k, v in pairs (rhs) do
    data [k] = (data [k] or 0) - v
  end
  return Marking.create (data)
end

return Marking
