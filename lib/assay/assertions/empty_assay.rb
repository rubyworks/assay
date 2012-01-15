require_relative 'assertion'

# Empty assertion tests an object with `#empty?` method.
#
class EmptyAssay < Assertion

  #
  def self.assertive_name
    :empty
  end

  #
  def self.operator
    :empty?
  end

  # Check assertion.
  def self.pass?(exp)
    exp.empty?
  end

  #
  def to_s
    return @mesg if @mesg
    return super unless @arguments.size == 1

    exp = @arguments.first.inspect

    if @_negated
      "Expected #{exp} to NOT be empty"  
    else
      "Expected #{exp} to be empty"
    end
  end

end

