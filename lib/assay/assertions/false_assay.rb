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
  def pass?(exp)
    FalseClass === exp
  end

  #
  def message(*arguments)
    return @mesg if @mesg
    return super unless arguments.size == 1

    exp = arguments[0].inspect

    if @_negated
      "Expected #{exp} to NOT be false"
    else
      "Expected #{exp} to be false"
    end
  end

end

