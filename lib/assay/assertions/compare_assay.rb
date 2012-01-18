require_relative 'assertion'

# Compare assertion serves primarily as a base class
# for other more specific comparison assertions.
#
# Maybe compare should just be <=> operation ?
#
class CompareAssay < Assertion

  # TODO: Not sure what this should be.
  def self.operator
    :cmp?
  end

  #
  def self.assertive_name
    :compare
  end

  #
  # Check assertion.
  #
  def self.pass?(actual, criterion, operator=:<=>)
    #raise ArgumentError unless [:<=>, :>, :<, :>=, :<=, :==].include?(operator.to_sym)
    criterion.__send__(operator, actual)
  end

  #
  def self.pass_message(actual, criterion, operator=:<=>)
    actual    = actual.inspect
    criterion = criterion.inspect

    if actual.size > SIZE_LIMIT or criterion.size > SIZE_LIMIT
      "a #{operator} b\na) #{criterion}\nb) #{actual}"
    else
      "#{criterion} #{operator} #{actual}"
    end
  end

end

