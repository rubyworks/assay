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
  def self.pass?(actual)
    TrueClass === actual
  end

  #
  def self.pass_message(actual)
    "true == #{actual.inspect}"
  end

  #
  def self.fail_message(actual)
    "true != #{actual.inspect}"
  end

end
