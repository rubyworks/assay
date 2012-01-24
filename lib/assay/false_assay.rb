require_relative 'boolean_assay'

class FalseAssay < BooleanAssay

  register :false

  #
  # Check assertion.
  #
  def self.pass?(subject)
    subject.false?  #FalseClass === subject
  end

end

