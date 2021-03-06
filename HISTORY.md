# HISTORY

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

