require_relative 'assertion'

# Assert that a container includes some object.
#
class IncludeAssay < Assertion

  register :include

  #
  # Check assertion using `#include?` method.
  #
  def self.pass?(container, member)
    container.include?(member)
  end

end

