require_relative 'boolean_assay'

# Assert and object if strictly `false`.
#
class FalseAssay < BooleanAssay

  register :false

  #
  # Check assertion.
  #
  def self.pass?(subject)
    subject.false?  #FalseClass === subject
  end

end

