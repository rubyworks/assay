require_relative 'compare_assay'

# Assert that an object is an instance of a class.
#
class InstanceAssay < CompareAssay

  #
  def self.operator
    :instance_of?
  end

  #
  def self.assertive_name
    :instance
  end

  # Check assertion.
  def pass?(obj, cls)
    obj.instance_of?(cls)
  end

  #
  def message(*arguments)
    return @mesg if @mesg
    return super unless arguments.size == 2

    obj = arguments[0].inspect
    cls = arguments[1].inspect

    if @_negated
      "Expected #{obj} to NOT be an instance of #{cls}"  
    else
      "Expected #{obj} to be an instance of #{cls}"
    end
  end
end

