require_relative 'compare_assay'

class FalseAssay < CompareAssay

  register :false

  #
  # Check assertion.
  #
  def self.pass?(subject)
    subject.false?  #FalseClass === subject
  end

  #
  #def pass_message(actual)
  #  "false == #{actual.inspect}"
  #end

  #
  #def fail_message(actual)
  #  "e != #{actual.inspect}"
  #end

end

