require_relative 'compare_assay'

# Comparison assertion for TrueClass.
#
#   TrueAssay.pass?(true) #=> true
#   TrueAssay.fail?(true) #=> false
#   TrueAssay.pass?(1)    #=> false
#
class TrueAssay < CompareAssay

  register :true

  #
  # Check assertion.
  #
  def self.pass?(subject)
    subject.true?  #TrueClass === subject
  end

  #
  #def self.pass_message(actual)
  #  "true == #{actual.inspect}"
  #end

  #
  #def self.fail_message(actual)
  #  "true != #{actual.inspect}"
  #end

end
