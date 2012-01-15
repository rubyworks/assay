require_relative 'compare_assay'

#
# TODO: assertive_name just doesn't cut it.
# 
class MatchAssay < CompareAssay

  #
  def self.assertive_name
    :match
  end

  #
  def self.operator
    :=~
  end

  # Check assertion.
  def self.pass?(exp, act)
    exp =~ act
  end

  # Check negated assertion.
  def self.fail?(exp, act)
    exp !~ act
  end

  #
  def self.assertable_method
    :assert_match
  end

  #
  def to_s
    return @mesg if @mesg
    return super unless @arguments.size == 2

    exp = @arguments[0].inspect
    act = @arguments[1].inspect

    if @_negated
      "Expected #{act} !~ #{exp}"
    else
      "Expected #{act} =~ #{exp}"
    end
  end

end