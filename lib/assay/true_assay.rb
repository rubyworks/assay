require_relative 'boolean_assay'

# Comparison assertion for TrueClass.
#
#   TrueAssay.pass?(true) #=> true
#   TrueAssay.fail?(true) #=> false
#   TrueAssay.pass?(1)    #=> false
#
class TrueAssay < BooleanAssay

  register :true

  #
  # Check assertion using `#true?` method.
  #
  def self.pass?(subject)
    subject.true?  #TrueClass === subject
  end

end
