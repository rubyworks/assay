require_relative 'execution_assay'

# Assert that a block of code returns a specific result, also
# fails if an error is raised in the block.
#
class ReturnAssay < ExecutionAssay

  register :returns

  #
  # Check that a block returns a specific value comparing 
  # the +returns+ argument and actual returned value with
  # the `#==` operator.
  #
  def self.pass?(returns, *arguments)  #:yield:
    begin
      result = yield(*arguments)
      returns == result
    rescue Exception
      false
    end
  end

  #
  # Check that a block does NOT return a specific value comparing 
  # the +returns+ argument and actual returned value with
  # the `#==` operator.
  #
  def self.fail?(returns, *arguments)  #:yield:
    begin
      result = yield(*arguments)
      returns != result
    rescue Exception
      true
    end
  end

  ##
  ##
  ##
  #def self.assert_message(*arguments, &block)
  #  "#{block}.call(*#{arguments.inspect})"
  #end

end

