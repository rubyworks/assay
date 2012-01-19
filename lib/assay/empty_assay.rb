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
  def self.pass?(actual)
    actual.empty?
  end

  #
  def self.pass_message(actual)
    "#{actual.inspect}.empty?"
  end

end

