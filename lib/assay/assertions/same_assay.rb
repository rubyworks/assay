require_relative 'compare_assay'

# Comparison assertion for the #eql? method.
#
class SameAssay < CompareAssay

  #
  def self.assertive_name
    :same
  end

  #
  def self.operator
    :eql?
  end

  # Check assertion.
  def self.pass?(exp, act)
    exp.eql?(act)
  end

  #
  def to_s
    return @mesg if @mesg
    return super unless @arguments.size == 2

    exp = @arguments[0].inspect
    act = @arguments[1].inspect

    if @_negated
      "Expected #{act} to NOT be the same as #{exp}"
    else
      "Expected #{act} to be the same as #{exp}"
    end
  end

end

