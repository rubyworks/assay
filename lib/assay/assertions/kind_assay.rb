require_relative 'compare_assay'

# Comparison assertion for #kind_of?
#
#   KindAssay.pass?(1, Integer)  #=> true
#   KindAssay.fail?(1, String)   #=> true
#
class KindAssay < CompareAssay

  #
  def self.assertive_name
    :kind_of
  end

  #
  def self.operator
    :kind_of?
  end

  # Check assertion.
  def self.pass?(act, exp)
    act.kind_of?(exp)
  end

  #
  def to_s
    return @mesg if @mesg
    return super unless @arguments.size == 2

    exp = @arguments[0].inspect
    act = @arguments[1].inspect

    if @_negated
      "Expected #{act} to be kind of #{exp}"
    else
      "Expected #{act} to be kind of #{exp}"
    end
  end
end

