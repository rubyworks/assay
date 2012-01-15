require_relative 'compare_assay'

class NilAssay < CompareAssay

  #
  def self.assertive_name
    :nil
  end

  #
  def self.operator
    :nil?
  end

  # Check assertion.
  def self.pass?(exp)
    exp.nil?
  end

  #
  def to_s
    return @mesg if @mesg
    return super unless @arguments.size == 1

    exp = @arguments[0].inspect

    if @_negated
      "Expected #{exp} to NOT be nil"
    else
      "Expected #{exp} to be nil"
    end
  end

end

