require_relative 'compare_assay'

#
#
class LikeAssay < CompareAssay

  #
  def self.operator
    :like?
  end

  #
  def self.assertive_name
    :like
  end

  # Test assertion.
  def pass?(act, exp)
    exp.equal?(act) ||
    #exp.eq?(act)    ||
    exp.==(act)     ||
    exp.===(act)
  end

  def message(*arguments)
    return @mesg if @mesg
    return super unless arguments.size == 2

    iexp = arguments[0].inspect
    iact = arguments[1].inspect

    "Expected #{iact} to be like #{iexp}"
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

