require_relative 'assertion'

# Compare assertion serves primarily as a base class
# for other more specific comparison assertions.
#
class CompareAssay < Assertion

  # TODO: Not sure what this should be.
  def self.operator
    :comp?
  end

  #
  def self.assertive_name
    :compare
  end

  #
  # Test assertion.
  #
  def pass?(object, operator, operand)
    #raise ArgumentError unless [:>, :<, :>=, :<=, :==].include?(op.to_sym)
    object.__send__(operator, operand)
  end

  #
  def message(*arguments)
    return @mesg if @mesg
    return super unless arguments.size == 3

    act = arguments[0].inspect
    op  = arguments[1].inspect
    exp = arguments[2].inspect

    "should -- #{exp} #{op} #{act}"
  end

  #
  #def to_s
  #  return @mesg if @mesg
  #  return super unless @arguments.size == 2
  #
  #  iexp = @arguments[0].inspect
  #  iact = @arguments[1].inspect
  #
  #  if @_negated
  #    "Expected #{iact} to NOT be like #{iexp}"
  #  else
  #    "Expected #{iact} to be like #{iexp}"
  #  end
  #end

end

