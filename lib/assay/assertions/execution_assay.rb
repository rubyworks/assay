require_relative 'assertion'

# Assert that a block of coded executes without error and does
# not return +nil+ or +false+.
#
# The ExecutionAssay is the base class of all other block-executing 
# assertion classes. The vary by the conditions for success they
# place on the executed procedure.
#
# NOTE: To test only for successful execution regardless of return value
# use a negated {RaiseAssay} on the Exception class. But generally 
# this would be pretty silly, if you think about it, this is exactly
# what testing is for!
#
class ExecutionAssay < Assertion

  #
  def self.operator
    :executes?
  end

  #
  def self.assertive_name
    :executes
  end

  # Check assertion.
  def pass?(*args, &block)
    begin
      block.call(*args)
    rescue Exception
      false
    end
  end

  # Check negated assertion.
  def fail?(*args, &block)
    begin
      !block.call(*args)
    rescue Exception
      true
    end
  end

  #
  def message(*arguments)
    return @mesg if @mesg

    if @_negated
      "Expected procedure to raise an exception."
    else
      "Expected procedure to execute successfully."
    end
  end

end

