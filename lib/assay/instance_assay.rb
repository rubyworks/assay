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

  #
  # Check assertion.
  #
  def self.pass?(object, class_type)
    object.instance_of?(class_type)
  end

  #
  #def pass_message(object, class_type)
  #  object = object.inspect
  #
  #  if object.size > SIZE_LIMIT
  #    "a.instance_of? b\na) #{object}\nb) #{class_type}"
  #  else
  #    "#{object}.instance_of? #{class_type}"
  #  end
  #end

end

