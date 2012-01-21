require_relative 'assertion'

# Empty assertion tests an object with `#empty?` method.
#
class EmptyAssay < Assertion

  #
  #operator :empty?

  #
  #def self.assertive_name
  #  :empty
  #end

  # Check assertion.
  def self.pass?(target)
    target.empty?
  end

end

