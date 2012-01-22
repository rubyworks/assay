require_relative 'assertion'

#
#
class IncludeAssay < Assertion

  register :include

  #
  # Check assertion using `#include?` method.
  #
  def self.pass?(container, member)
    container.include?(member)
  end

#  #
#  def self.pass_message(container, member)
#    container = container.inspect
#    member    = member.inspect
#
#    if container.size > SIZE_LIMIT or member.size > SIZE_LIMIT
#      "a.include? b\na) #{container}\nb) #{member}"
#    else
#      "#{container}.include? #{member}"
#    end
#  end

end

