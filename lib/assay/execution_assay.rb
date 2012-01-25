require_relative 'assertion'

# Assert that a block of coded executes without error and does
# not return +nil+ or +false+.
#
# The ExecutionAssay is the base class of most other block-executing 
# assertion classes. They vary by the conditions for success they
# place on the executed procedure.
#
# NOTE: To test only for successful execution regardless of return value
# use a negated {RaiseAssay} on the Exception class. But generally 
# this would be pretty silly, if you think about it, this is exactly
# what testing is for!
#
# TODO: SHould thit just be equivalent to nothing raised? And have 
# another for truthful output?
#
class ExecutionAssay < Assertion

  register :executes

  #
  # Check assertion.
  #
  def self.pass?(*arguments, &block)
    begin
      block.call(*arguments)
    rescue Exception
      false
    end
  end

  #
  # Check negated assertion.
  #
  def self.fail?(*arguments, &block)
    begin
      ! block.call(*arguments)
    rescue Exception
      true
    end
  end

  #
  #def self.assert!(*criteria, &block)
  #  options = (Hash === criteria.last ? criteria.pop : {})
  #  assay = new(nil, *criteria) #, &block)
  #  assay.assert!(options, &block)
  #end

  #
  #def self.refute!(*criteria, &block)
  #  options = (Hash === criteria.last ? criteria.pop : {})
  #  assay = new(nil, *criteria) #, &block)
  #  assay.refute!(options, &block)
  #end

  #
  #
  #
  def self.assert_message(*arguments, &block)
    "#{block}.call(*#{arguments.inspect})"
  end

end

