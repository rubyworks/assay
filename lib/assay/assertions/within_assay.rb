require_relative 'compare_assay'

# TODO: Support Range for Delta comparisons.

#
class WithinAssay < CompareAssay

  #
  def self.operator
    :within?
  end

  #
  def self.assertive_name
    :within
  end

  # Check assertion.
  def pass?(act, exp, delta)
    case delta
    when Numeric
      (exp.to_f - act.to_f).abs <= delta.to_f
    else
      exp - act <= delta
    end
  end

  #
  def message(*arguments)
    return @mesg if @mesg
    return super unless arguments.size == 3

    exp   = arguments[0].inspect
    act   = arguments[1].inspect
    delta = arguments[2].inspect
  
    if @_negated
      "Expected #{exp} to NOT be within #{delta} of #{act}"
    else
      "Expected #{exp} to be within #{delta} of #{act}"
    end
  end

  #
  #def to_s
  #  return @mesg if @mesg
  #  return super unless @arguments.size == 3
  #
  #  exp   = @arguments[0].inspect
  #  act   = @arguments[1].inspect
  #  delta = @arguments[2].inspect
  #
  #  if @_negated
  #    "Expected #{exp} to NOT be within #{delta} of #{act}"
  #  else
  #    "Expected #{exp} to be within #{delta} of #{act}"
  #  end
  #end

end

