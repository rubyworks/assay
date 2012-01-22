require_relative 'assertion'

# Comparison assertion for #kind_of?
#
#   KindAssay.pass?(1, Integer)  #=> true
#   KindAssay.fail?(1, String)   #=> true
#
class KindAssay < Assertion

  register :kind_of

  # Check assertion.
  def self.pass?(object, class_type)
    object.kind_of?(class_type)
  end

  #
  #def pass_message(object, class_type)
  #  object = object.inspect
  #
  #  if object.size > SIZE_LIMIT
  #    "a.kind_of? b\na) #{object}\nb) #{class_type}"
  #  else
  #    "#{object}.kind_of? #{class_type}"
  #  end
  #end

end

