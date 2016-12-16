# Modeling & Verification Homework #1

This repository is the starter for homework #1 of the course
["Modeling & Verification"](https://moodle.unige.ch/course/view.php?id=183)
at [University of Geneva](http://www.unige.ch).

## Environment

Please install the [environment](https://github.com/cui-unige/modeling-verification).
Install also an additional library but running in a terminal the command:

```sh
  luarocks install rockspec/fun-scm-1.rockspec
```

## Subject

You have to complete programs to compute, from a Place/Transition Petri net:
* its reachability graph;
* its coverability graph;
* its place invariants;
* its transition invariants.

You must only implement parts shown by `FIXME` comments in the source code.
Do **not** touch other algorithms.
You are allowed to add extra functions if needed.

At the beginning, you already have:
* a representation for Petri nets (with tests);
* a representation for their markings (with tests);
* a representation for their states (with tests);
* a parameterized algorithm to compute the reachability and coverability graphs;
* a parameterized algorithm to compute place and transition invariants;
* some Petri nets that can be used in tests.

## Comments on Code

Modules/classes are in Uppercase, instances are in lowercase.

### Iterators and Functions

We use [luafun](https://github.com/rtsisyk/luafun) to manipulate collections
and iterators.

* `Fun.all (predicate, iterator)` checks that all elements in `iterator`
  match `predicate`.
* `Fun.each (function, iterator)` applies `function` to all elements in
  `iterator`.
* `Fun.map (function, iterator)` applies `function` to all elements in
  `iterator` and returns an iterator over the results.
  If `function` returns one result, the iterator contains only values.
  If `function` returns two results, the iterator contains key-value pairs.
* `Fun.totable (iterator)` returns a Lua table built from elements in an
  `iterator` that contains only values.
  Elements in the table are indexed by numbers, starting at 1.
* `Fun.tomap (iterator)` returns a Lua table built from elements in an
  `iterator` that contains keys and values.
  Elements in the table are indexed by keys.
* Other functions to discover in the documentation!

### Petri net

Examples of Petri nets are given in files `page*.lua`.

* `Petrinet.create ()` returns a new Petri net.
* `petrinet:place (marking)` returns a new place with initial `marking`.
  This place must be stored within the Petri net to be considered.
* `petrinet:places ()` returns an iterator over the places of the Petri net.
  Each place contains a `marking` field with its initial marking.
* `petrinet:transition (t)` returns a new transition with arcs described in `t`.
  This transition must be stored within the Petri net to be considered.
  `t` is a table that maps places to the arc valuation (negative for pre arcs,
  positive for post arcs).
* `petrinet:transitions ()` returns an iterator over the transitions of the
  Petri net.
  Each transition contains the mapping given as parameter `t` when it was built.
* `transition:pre ()` returns an iterator over the pre arcs of the transition.
  Each arc contains a `place` field that stores the input place,
  and a `valuation` field that stores the arc valuation (a positive number).
* `transition:post ()` returns an iterator over the post arcs of the transition.
  Each arc contains a `place` field that stores the output place,
  and a `valuation` field that stores the arc valuation (a positive number).

### Marking

* `Marking.omega` is a constant for the "ω" marking.
* `Marking.initial (petrinet)` returns the initial marking of `petrinet`.
* `Marking.create (t)` returns a new marking.
  `t` is a table that maps places to their number of tokens.
* `m1 == m2` returns `true` if and only if both markings are equal.
* `m1 <= m2` returns `true` if and only if `m1` is included in `m2`
  or if they are equal.
* `m1 < m2` returns `true` if and only if `m1` is included in `m2`
  and they are not equal.
* `m1 + m2` returns a new marking that is the sum of `m1` and `m2`.
* `m1 - m2` returns a new marking that is the difference between `m1` and `m2`.

### State

* States are vertices of the reachability or coverability graph.
* Each state contains a `petrinet` field for its Petri net,
  a `marking` field for the marking of this state,
  and a `successors` field that maps transitions to the successor states.
* `State.create (petrinet)` creates an initial state for `petrinet`.
* `state (transition)` returns a new state, obtained by firing `transition`
  on `state.`
  In case of failure, it returns `nil`.
* `state:enabled ()` returns an iterator over the transitions enabled in
  `state`.
* `s1 <= s2` returns `true` if and only if `s1` is a predecessor of `s2`
  in the graph, or if they are the same state.
* `s1 < s2` returns `true` if and only if `s1` is a predecessor of `s2`
  in the graph and they are not the same state.
* `tostring (state)` returns a string representation of the marking of a state.

### Graph

* `Graph.create (options)` returns a new graph builder (not a new graph).
  `options` contains two fields: `traversal`, the traversal strategy,
  and `omegize`, a function only used in coverability graph.
* `Graph.breadth_first` is one traversal strategy.
* `Graph.depth_first` is another traversal strategy.
* `graph.traversal (work)` returns an element of `work`,
  and also removes it from `from`.
* `graph (petrinet)` builds a graph, starting from the initial state of
  `petrinet`.
  It returns the initial state, and the set of states.
* `Reachability.create (options)` returns a graph builder with `options`,
  configured for reachability graph generation.
* `Coverability.create (options)` returns a graph builder with `options`,
  configured for coverability graph generation.

### Invariant

* `Farkas.create (petrinet)` creates a Farkas algorithm configured for
  `petrinet`.
* `farkas:entry (t)` creates a new entry, i.e., a row index, from `t`.
  `t` is a mapping from places or transitions to coefficients,
  that are interpreted as a linear combination.
  For instance `t = { [p1] = 2, [p2] = 1 }` means `2*p1 + 1*p2`.
* `farkas (matrix)` computes the Farkas algorithm on `matrix`.
  `matrix` is a mapping from entries (row indices) to columns.
  Each columns is a mapping from places or transitions to the value within
  the matrix cell.
* `tostring (entry)` returns a string representation of the entry
  in a readable format.
* `Place.create ()` returns a new invariant builder for place invariants.
* `Transition.create ()` returns a new invariant builder for transition
  invariants.
* `builder (petrinet)` applies invariant computation to `petrinet`.
  It returns a mapping from entries to columns.

### Tests

* All tests are put in `*_spec.lua` files.
* To run only some tests, add a tag to them (for example tag `#test`):

  ```lua
  describe ("#test Place invariants", function () ...
  ```
  And then run from the root of the repository:

  ```sh
  busted --tags=test src/
  ```

## Rules

* We use [GitHub Classroom](https://classroom.github.com) for the homework.
* If for any reason you have trouble with the deadline,
  contact your teacher as soon as possible.
* Your source code (and tests) must pass all checks of `luacheck`
  without warnings or errors.
* Your tests must cover at least 80% of the source code (excluding test files).
* Your work will be tested in a dedicated environment, using `wercker`.
  You can always run all the tests on your code with the following command,
  from the root of your project (where the `wercker.yml` file is located):

  ```sh
  $ wercker build
  ```

## Evaluation

Evaluation follows the questions:
* do you have done anything at the deadline?
  (no: 0 points)
  * [ ] Done anything
* do you have understood and implemented all the required notions?
  (yes: 4 points for all, no: 2 points for none)
  * [ ] Reachability graph
  * [ ] Coverability graph
  * [ ] Place invariants
  * [ ] Transition invariants
* do you have understood and implemented corners cases of all the required
  notions?
  (yes: +2 point for all)
  * [ ] Reachability graph
  * [ ] Coverability graph
  * [ ] Place invariants
  * [ ] Transition invariants
* do you have correctly written and tested your code?
  (no: -0.5 point for each)
  * [ ] Coding standards
  * [ ] Tests
  * [ ] Code coverage

| Grade |
| ----- |
|   0   |
