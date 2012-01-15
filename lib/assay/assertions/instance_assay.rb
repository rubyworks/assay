require_relative 'compare_assay'

# Assert that an object is an instance of a class.
#
class InstanceAssay < CompareAssay

  #
  def self.assertive_name
    :instance
  end

  #
  def self.operator
    :instance_of?
  end

  # Check assertion.
  def self.pass?(act, exp)
    act.instance_of?(exp)
  end

  #
  def to_s
    return @mesg if @mesg
    return super unless @arguments.size == 2

    exp = @arguments[0].inspect
    act = @arguments[1].inspect

    if @_negated
      "Expected #{act} to NOT be an instance of #{exp}"  
      else
      "Expected #{act} to be an instance of #{exp}"
    end
  end
end

