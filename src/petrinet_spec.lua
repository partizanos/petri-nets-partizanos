local assert   = require "luassert"
local Petrinet = require "petrinet"

describe ("Petri nets", function ()

  it ("can be created", function ()
    local petrinet = Petrinet.create ()
    assert.are.equal (getmetatable (petrinet), Petrinet)
  end)

  it ("can create a place with an implicit marking", function ()
    local petrinet = Petrinet.create ()
    petrinet.p     = petrinet:place  ()
    assert.are.equal (getmetatable (petrinet.p), Petrinet.Place)
    assert.are.equal (petrinet.p.marking, 0)
  end)

  it ("can create a place with an explicit marking", function ()
    local petrinet = Petrinet.create ()
    petrinet.p     = petrinet:place  (5)
    assert.are.equal (getmetatable (petrinet.p), Petrinet.Place)
    assert.are.equal (petrinet.p.marking, 5)
  end)

  it ("can iterate over its places", function ()
    local petrinet = Petrinet.create ()
    petrinet.p     = petrinet:place  (5)
    petrinet.q     = petrinet:place  (0)
    local result   = {}
    for _, v in petrinet:places () do
      result [#result+1] = v
      assert.are.equal (getmetatable (v), Petrinet.Place)
    end
    assert.are.equal (#result, 2)
  end)

  it ("can create a transition", function ()
    local petrinet = Petrinet.create ()
    petrinet.p     = petrinet:place  ()
    petrinet.q     = petrinet:place  ()
    petrinet.t     = petrinet:transition {
      petrinet.p - 1,
      petrinet.q + 1,
    }
    assert.are.equal (getmetatable (petrinet.t), Petrinet.Transition)
    assert.are.equal (getmetatable (petrinet.t [1]), Petrinet.Arc)
    assert.are.equal (getmetatable (petrinet.t [2]), Petrinet.Arc)
    assert.are.equal (petrinet.t [1].place    , petrinet.p)
    assert.are.equal (petrinet.t [2].place, petrinet.q)
    assert.are.equal (petrinet.t [1].valuation, 1)
    assert.are.equal (petrinet.t [2].valuation, 1)
  end)

  it ("can iterate over its transitions", function ()
    local petrinet = Petrinet.create ()
    petrinet.p     = petrinet:place  ()
    petrinet.q     = petrinet:place  ()
    petrinet.t     = petrinet:transition {
      petrinet.p - 1,
      petrinet.q + 1,
    }
    petrinet.u     = petrinet:transition {
      petrinet.q - 1,
      petrinet.p + 1,
    }
    local result   = {}
    for _, v in petrinet:transitions () do
      result [#result+1] = v
      assert.are.equal (getmetatable (v), Petrinet.Transition)
    end
    assert.are.equal (#result, 2)
  end)

  it ("can iterate over pre arcs", function ()
    local petrinet = Petrinet.create ()
    petrinet.p     = petrinet:place  ()
    petrinet.q     = petrinet:place  ()
    petrinet.t     = petrinet:transition {
      petrinet.p - 1,
      petrinet.q + 1,
    }
    local result   = {}
    for _, v in petrinet.t:pre () do
      result [#result+1] = v
      assert.are.equal (getmetatable (v), Petrinet.Arc)
    end
    assert.are.equal (#result, 1)
  end)

  it ("can iterate over post arcs", function ()
    local petrinet = Petrinet.create ()
    petrinet.p     = petrinet:place  ()
    petrinet.q     = petrinet:place  ()
    petrinet.t     = petrinet:transition {
      petrinet.p - 1,
      petrinet.q + 1,
    }
    local result   = {}
    for _, v in petrinet.t:post () do
      result [#result+1] = v
      assert.are.equal (getmetatable (v), Petrinet.Arc)
    end
    assert.are.equal (#result, 1)
  end)

end)
