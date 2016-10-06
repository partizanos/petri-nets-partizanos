local assert    = require "luassert"
local Fun       = require "fun"
local Invariant = require "invariant.place"
local p21       = require "petrinet.page21"

describe ("Place invariants", function ()

  it ("can be created", function ()
    local invariant = Invariant.create ()
    assert.are.equal (getmetatable (invariant), Invariant)
  end)

  it ("can be computed on a Petri net", function ()
    local invariant = Invariant.create ()
    local result    = Fun.totable (invariant (p21))
    for k, v in pairs (result) do
      print (k, v)
    end
  end)

end)
