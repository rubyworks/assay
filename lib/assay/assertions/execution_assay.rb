require_relative 'assertion'

# FIXME: This thing needs work!!!!!!!!!!!!

# Assert that a block of coded executes without error.
#
# ExecutionAssay is also the base class of the other
# block-executing assertion classes.
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

