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

end

