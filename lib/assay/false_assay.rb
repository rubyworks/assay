require_relative 'compare_assay'

class FalseAssay < CompareAssay

  #
  #def self.operator
  #  :false?
  #end

  #
  def self.assertive_name
    :false
  end

  #
  # Check assertion.
  #
  def self.pass?(target)
    FalseClass === target  #.false?
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

