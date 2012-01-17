require_relative 'assertion'

#
#
class IncludeAssay < Assertion

  #
  def self.operator
    :include?
  end

  #
  def self.assertive_name
    :include
  end

  # Check assertion.
  def pass?(container, object)
    container.include?(object)
  end

  #
  def message(*arguments)
    return @mesg if @mesg
    return super unless arguments.size == 3

    container = arguments[0].inspect
    object    = arguments[1].inspect
  
    if @_negated
      "Expected #{object} to NOT be included in #{container}"
    else
      "Expected #{object} to be included in #{container}"
    end
  end

end

