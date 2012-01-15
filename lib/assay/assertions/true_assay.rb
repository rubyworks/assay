require_relative 'compare_assay'

# Comparison assertion for TrueClass.
#
#   TrueAssay.pass?(true) #=> true
#   TrueAssay.fail?(true) #=> false
#   TrueAssay.pass?(1)    #=> false
#
class TrueAssay < CompareAssay

  #
  def self.assertive_name
    :true
  end

  #
  def self.operator
    :true?
  end

  # Check assertion.
  def self.pass?(exp)
    TrueClass === exp
  end

  #
  def to_s
    return @mesg if @mesg
    return super unless @arguments.size == 1

    exp = @arguments[0].inspect

    if @_negated
      "Expected #{exp} to NOT be true"
    else
      "Expected #{exp} to be true"
    end
  end

end
