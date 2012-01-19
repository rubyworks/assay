require_relative 'compare_assay'

class FalseAssay < CompareAssay

  #
  def self.operator
    :false?
  end

  #
  def self.assertive_name
    :false
  end

  # Check assertion.
  def self.pass?(actual)
    FalseClass === actual
  end

  #
  def self.pass_message(actual)
    "false == #{actual.inspect}"
  end

  #
  def self.fail_message(actual)
    "false != #{actual.inspect}"
  end

end

