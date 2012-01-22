require_relative 'compare_assay'

class NilAssay < CompareAssay

  register :nil

  #
  # Check assertion.
  #
  def self.pass?(subject)
    subject.nil?
  end

  #
  #def self.pass_message(actual)
  #  "nil == #{actual.inspect}"
  #end

  #
  #def self.pass_message(actual)
  #  "nil != #{actual.inspect}"
  #end

end

