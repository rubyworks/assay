require_relative 'compare_assay'

class NilAssay < CompareAssay

  #
  def self.assertive_name
    :nil
  end

  #
  # Check assertion.
  #
  def self.pass?(actual)
    actual.nil?
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

