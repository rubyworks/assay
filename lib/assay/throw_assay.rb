require_relative 'execution_assay'

# Assertion for catching specific throws.
#
class ThrowAssay < ExecutionAssay

  register :throw

  # TODO: Is it possible to catch _any_ type of throw? If so make the
  #       argument optional for that.

  # Passes if the block throws expected_symbol
  #
  #   ThrowAssay.pass? :done do
  #     throw :done
  #   end
  #
  def self.pass?(symbol, &block)
    pass = true
    catch(symbol) do
      begin
        block.call
      rescue ArgumentError => err     # 1.9 exception
        #msg += ", not #{err.message.split(/ /).last}"
        pass = false
      rescue NameError => err         # 1.8 exception
        #msg += ", not #{err.name.inspect}"
        pass = false
      end
    end
    pass
  end

  # FIXME: Is this correct?

  # Passes if the block throws expected_symbol
  #
  #   assert_not_thrown :done do
  #     throw :chimp
  #   end
  #
  def self.fail?(symbol, &block)
    pass = false
    catch(symbol) do
      begin
        block.call
      rescue ArgumentError => err     # 1.9 exception
        #msg += ", not #{err.message.split(/ /).last}"
        pass = true
      rescue NameError => err         # 1.8 exception
        #msg += ", not #{err.name.inspect}"
        pass = true
      end
    end
    pass
  end

  #
  def pass_message(symbol)
    s = symbol.inspect
    "throw #{s}"
  end

end
