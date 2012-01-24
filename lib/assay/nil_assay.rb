require_relative 'assertion'

class NilAssay < Assertion

  register :nil

  #
  # Check assertion.
  #
  def self.pass?(subject)
    subject.nil?
  end

end

