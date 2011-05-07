require 'assay/assertions/execution_failure'

module Assay

  #
  class ThrowFailure < ExecutionFailure

    def self.assertion_name
      :throws
    end

    def self.assertion_name!
      :not_thrown
    end

    # Passes if the block throws expected_symbol
    #
    #   assert_throws :done do
    #     throw :done
    #   end
    #
    def self.pass?(sym, &block)
      pass = true
      catch(sym) do
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

    # Passes if the block throws expected_symbol
    #
    #   assert_not_thrown :done do
    #     throw :chimp
    #   end
    #
    # FIXME: Is this correct?
    def self.fail?(sym, &block)
      pass = false
      catch(sym) do
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
    def to_s
      return @mesg if @mesg
      return super unless @arguments.size == 1

      sym = @arguments[0].inspect

      if @_negated
        "Expected #{sym} to have been thrown"
      else
        "Expected #{sym} NOT to have been thrown"
      end
    end

  end


  module Assertives
    # Passes if the block throws expected_symbol
    #
    #   assert_throws :done do
    #     throw :done
    #   end
    #
    def assert_throws(sym, msg=nil, &blk)
      ThrowFailure.assert(sym, :message=>msg, :backtrace=>caller, &blk)
    end

    # Passes if the block throws expected_symbol
    #
    #   refute_throws :done do
    #     throw :chimp
    #   end
    #
    def refute_throws(sym, msg=nil, &blk)
      ThrowFailure.refute(sym, :message=>msg, :backtrace=>caller, &blk)
    end

    alias_method :assert_not_thrown, :refute_throws
  end


  module Matchers
    #
    #
    #   :symbol.assert is_thrown{ ... }
    #
    def is_thrown(&blk)
      ThrowFailure.to_matcher(&blk)
    end

    #
    #
    #   :symbol.should be_thrown{ ... }
    #
    def be_thrown(&blk)
      ThrowFailure.to_matcher(&blk)
    end
  end

end

