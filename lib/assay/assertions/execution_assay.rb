require_relative 'assertion'

# FIXME: This thing needs work!!!!!!!!!!!!

# Assert that a block of coded executes without error.
#
# ExecutionAssay is also the base class of the other
# block-executing assertion classes.
#
class ExecutionAssay < Assertion

  #
  def self.assertive_name
    :executes
  end

  #
  def self.subjective_name
    :executed
  end

  # Check assertion.
  def self.pass?(_=nil, &block)
    begin
      block.call
      true
    rescue Exception
      false
    end
  end

  # Check negated assertion.
  def self.fail?(_=nil, &block)
    begin
      block.call
      false
    rescue Exception
      true
    end
  end

  #
  def to_s
    return @mesg if @mesg
    if @_negated
      "Expected procedure to raise an exception."
    else
      "Expected procedure to execute successfully."
    end
  end

end

