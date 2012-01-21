require_relative 'assertion'

# EqualityAssay defines the assertion for the `#eql?`, the strict equality
# method.
#
# The `EqualityAssay` class also acts as the base class for other forms of 
# equality such as {EqualAssay} class, {UnequalAssay} and {CaseAssay}
# classes.
#
class EqualityAssay < Assertion

  #
  def self.operator
    :eql?
  end

  #
  def self.assertive_name
    :eql
  end

  #
  # Check assertion via `#eql?` method.
  #
  def self.pass?(target, criterion)
    criterion.eql?(target)
  end

end

