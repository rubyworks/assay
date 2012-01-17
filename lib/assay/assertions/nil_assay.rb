require_relative 'compare_assay'

class NilAssay < CompareAssay

  #
  def self.operator
    :nil?
  end

  #
  def self.assertive_name
    :nil
  end

  # Check assertion.
  def pass?(exp)
    exp.nil?
  end

  #
  def message(*arguments)
    return @mesg if @mesg
    return super unless arguments.size == 1
  
    exp = arguments[0].inspect
  
    if @_negated
      "Expected #{exp} to NOT be nil"
    else
      "Expected #{exp} to be nil"
    end
  end

end

