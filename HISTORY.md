# HISTORY

## Unreleased

Assay is one library again. The notations that were spun off as separate
gems in 0.4 (Fluidity, RSpecial, Assay MiniTest and Assay TestUnit) are
back, each loaded on its own, and Bang joins them. Assay needs Ruby 2.7 or newer.

Changes:

* Add `assay/fluidity`, the fluent notation (`x.should.equal y`), from
  the Fluidity gem. Its module is `Assay::Fluidity`.
* Add `assay/rspec`, RSpec-style matchers and `expect`, from the RSpecial
  gem. Its module is `Assay::RSpec`.
* Add `assay/minitest` and `assay/testunit`, the assertion methods of
  those frameworks, from the Assay MiniTest and Assay TestUnit gems.
* Add `assay/bang`, from the Bang gem, rebuilt on Assay's classes:
  `x.equal!(y)` fails with an `EqualAssay`. A query method Assay has
  no class for still works (`10.even!`) and fails with an `Assertion`.
* Fix a Hash under test being taken for options, which made comparing
  two hashes raise ArgumentError in every notation. Only a trailing
  Hash whose keys are all `:message` or `:backtrace` is options now.
* Rewrite the Minitest and Test::Unit adapters for Minitest 5 and 6 and
  for test-unit 3. The old ones patched classes those frameworks no
  longer have.
* `expect` takes a block: `expect{ ... }.to raise_error(ArgumentError)`.
* Fix `assert(false)` passing silently once `assay/fluidity/assert` was
  loaded. Worse, Assay itself called that `assert`, so no assay could
  fail either.
* Fix fluent assertions that used a method every object has, such as
  `x.should.be.kind_of?(String)`, `x.assert.nil?` or `x.assert != y`.
  The grammar object answered them itself, so they never failed. This
  goes back to the Fluidity gem. Likewise `expect(x).to.kind_of?(String)`
  in the RSpec notation, which is now a NoMethodError.
* The fluent notation passes keyword arguments on to an object's own
  query method.
* Fix the fluent fallback to an object's own query method ignoring
  negation: `x.should_not.be.no` now fails when `x.no?` is true.
* Fix `will_not` and `wont`. They were never defined, and loading the
  `will` notation raised NameError.
* Fix `assert_in_epsilon` and `assert_not_in_epsilon` in the Test::Unit
  notation, which raised NameError.
* Fix `CloseAssay` for a negative criterion, and its message for long
  values.
* Give `LessAssay`, `LessEqualAssay`, `MoreAssay` and `MoreEqualAssay`
  messages of their own (`5 <= 3`). They said `5 <=> 3 == 0`.
* `Kernel#like?` no longer tries `=~`, which Ruby 3.2 removed from
  Object. It is now the same as Facets' `like?`.
* An operator with no assay of its own, used with `expect(x).to`, is
  sent to the object and fails with an Assertion. It raised an
  unrelated error.
* Assay's failures no longer depend on which `assert` method is in
  scope: it calls BRASS's directly.
* `Assay::VERSION` gives the version. `Assay.metadata`, and the
  constants made from it, are gone.
* Replace the old packaging (`.index`, `.gemspec`, `Assembly`,
  `MANIFEST`) with a plain `assay.gemspec`, and Travis with GitHub
  Actions, testing Ruby 2.7 to 4.0.


## 0.4.1 | 2012-01-27

This release adds CloseAssay for relative approxmation assertions on values,
where as the WithinAssay handles absolute difference.

Changes:

* Add CloseAssay for relative approximation.
* Use past tense for RescueAssay's assertive name, i.e. :rescued.


## 0.4.0 | 2012-01-25

Version 0.4 is a very polished partial rewrite of the Assay project.
This release sheds all ancillary code to separate projects. The 
compatibility layers are now `assay-testunit`, `assay-minitest` and
`assay-rspec`. The built-in grammar is now the `fluidity` project.
All assertion classes now end with `Assay` suffix instead of `Failure`
and they are defined at the toplevel.

Changes:

* Spin-off all ancillary code, leaving only core functionality.
* Polish and semi-rewrite code.
* Renamed all Assertion subclasses form xxxFailure to xxxAssay.
* Add many new Assertion subclasses.


## 0.3.0 | 2011-05-07

This release fix the interface of the assertive methods so they accept
a message argument, like the original testunit.

Changes:

* Fix assertive methods to take message argument.
* Fix Assertion class to store message.


## 0.2.0 | 2011-05-05

This release of Assay is in good working order and can now be used
by other frameworks such as A.E. The only caveats at this point
are the Matcher API, which is still a bit unstable as the names of
some of its methods may yet change, and the error messages
for the various Failure classes still need improvement.

Changes:

* Add adapters for minitest and testunit.
* Add colorized comparison to EqualityFailure (via ANSI gem).
* Use standard exception messages (#to_s) instead of class methods.


## 0.1.0 | 2010-11-14

This is the initial working version of Assay.
But it is far from ready for widespread usage.

Changes:

* Happy Birthday!

