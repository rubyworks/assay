require_relative 'kind_assay'

# Assert that an object is an instance of a class.
#
class InstanceAssay < KindAssay

  register :instance_of

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

