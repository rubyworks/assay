require_relative 'execution_assay'

# Assertion for catching specific throws.
#
class ThrowAssay < ExecutionAssay

  register :throw

  # TODO: Is it possible to catch _any_ type of throw? If so make the
  #       argument optional for that.

  # Passes if the block throws given symbol.
  #
  #   ThrowAssay.pass? :done do
  #     throw :done
  #   end
  #
  # If no symbol is given than passes if any is thrown.
  # But note that in `#assert!`, the symbol must be `nil`
  # rather than not given.
  #
  def self.pass?(symbol=nil) #:yield:
    pass = true
    if symbol
      catch(symbol) do
        begin
          yield
        rescue ArgumentError => err     # 1.9 exception
          #msg += ", not #{err.message.split(/ /).last}"
        rescue NameError => err         # 1.8 exception
          #msg += ", not #{err.name.inspect}"
        end
        pass = false
      end
    else
      begin
        yield
        pass = false
      rescue ArgumentError => error
        pass = false if /\Auncaught throw (.+)\z/ !~ error.message
      end
    end
    pass
  end

  # Passes if the block does not throw given +symbol+.
  #
  #   ThrowAssay.fail? :done do
  #     throw :chimp
  #   end
  #
  # If no symbol is given then passes if nothing is thrown.
  # But note that in `#refute!`, the symbol must be `nil`
  # rather than not given.
  #
  def self.fail?(symbol=nil) #:yield:
    if symbol
      pass = false
      catch(symbol) do
        begin
          yield
        rescue ArgumentError => err     # 1.9 exception
          #msg += ", not #{err.message.split(/ /).last}"
        rescue NameError => err         # 1.8 exception
          #msg += ", not #{err.name.inspect}"
        end
        pass = true
      end
    else
      pass = false
      begin
        yield
        pass = true
      rescue ArgumentError => error
        pass = true if /\Auncaught throw (.+)\z/ !~ error.message
      end
    end
    pass
  end

  #
  #
  #
  def self.assert_message(symbol)
    s = symbol.inspect
    "throw #{s}"
  end

end
