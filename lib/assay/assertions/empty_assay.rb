require_relative 'assertion'

# Empty assertion tests an object with `#empty?` method.
#
class EmptyAssay < Assertion

  #
  def self.operator
    :empty?
  end

  #
  def self.assertive_name
    :empty
  end

  # Check assertion.
  def pass?(exp)
    exp.empty?
  end

  #
  def message(*arguments)
    return @mesg if @mesg
    return super unless arguments.size == 1

    exp = arguments.first.inspect

    "should be empty -- #{exp}"
  end

end

