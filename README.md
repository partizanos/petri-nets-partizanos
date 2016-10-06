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
|       |
