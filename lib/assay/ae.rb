require_relative '../assay'

require_relative 'ae/assertor'
require_relative 'ae/assert'
require_relative 'ae/expect'

# The AE notation, from the Assertive Expressive (AE) gem: any method of
# the object under test becomes an assertion when called through `assert`.
#
#   x.assert == y
#   a.assert.include?(e)
#   x.refute.nil?
#
#   expect ArgumentError do
#     ...
#   end
#
# Where Assay has a class for the method, a failure is of that class;
# otherwise it is a plain Assertion. The subjunctive verbs, and the
# `ok`/`no` checks, are loaded separately:
#
#   require 'assay/ae/should'
#   require 'assay/ae/must'
#   require 'assay/ae/check'
#
class ::Object
  include ::Assay::AE::Assert
  include ::Assay::AE::Expect
end
