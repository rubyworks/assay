require_relative 'assertion'

class BooleanAssay < Assertion

  register :boolean

  #
  # Check assertion.
  #
  def self.pass?(subject)
    subject.true? || subject.false?  # TODO: Kernel#boolean? method
  end

end

