# TODO

## Stage 1

- FIXES:
- CLEANUP:
  - [x] use what is now `Reason` as `ReaderError`, rename `ReaderError` to something else
  - [ ] move (de)serializers from Main
  - [ ] better readme
  - [ ] try to remove T.pack/unpack as much as possible
  - [x] newtypes for restricted strings
  - [x] hackage docs
  - [?] module Data.Range (ORDS(DisjointGT,TangentGT,OverlapGT,ContainGT,EQ,..)Ords(compares))
      - possibly just use hackage `range` library
  - [x] output tbnf.tbnf Define form to Haskell
  - [x] import control
  - [x] Rule.Void
  - [x] documentation if TBNF
  - [x] better position type
  - [x] ErrorReport should be a record
  - [x] Texpr.Error (and ErrorReport) should carry a "reason", which is just the expected set + position
- FEATURES:
  - [x] application that parses into texprs
    - `texpr >input <peg-over-strings-file> [<peg-over-texprs-file>...] >output`
    - [x] parse options
    - [x] read and compile grammars
    - [x] output texpr
    - [x] read input texprs
    - [x] output short form texpr
    - [x] render errors nicely
    - [ ] render errors even more nicely
  - [x] allow subtraction in char classes
    - [x] and also, tidy up that syntax pLEASE!
  - [x] primitive grammars
    - 6 columns: Tree.hs, Generic.hs, Define.hs, Compile.hs, Bootstrap.hs, tbnf.tbnf
    - [x] shallow Texpr Combo
    - [x] Expect
    - [x] deep Texpr combo
    - [x] deep Texpr atom
    - [x] Any (char or texpr)
    - [x] empty sequence
    - [x] Lookahead
    - [x] Not (negative lookahead)
    - Repeat-Until === (g ?!"msg" g2)*
    - [?] Intersect, if I can figure out what the second grammar should match against
      - alternately, Implies, where the output of the first is passed to the second to match in full, and the final output is the output of the second
  - [ ] simplify/optimize the rules
    - [ ] match many chars in flat mode
    - [ ] un-nest seq and alt
    - [ ] eliminate identity elements for seq and alt
    - [ ] trim away unused rules
  - [ ] extend rules and sets
  - [ ] import grammars
- TESTING:
  - [ ] implement autotab with autotab.tbnf

## Stage 2

- [x] standard for serializing texpr streams
- [ ] texpr rewriter language
  - [ ] define a textual grammar for rewriters
  - [x] the match/rewrite algorithm


## Use Texprs/Trwl

- listdown
- natural deduction unicode -> latex
- autows

## Stage 3+

- [ ] better error detection/reporting for trwl
- [?] when erroring, collect a context along with the input so that parsing can be resumed
- interfaces:
  - [ ] represent grammars (high- and low-level) as json
  - [ ] render grammars to html
