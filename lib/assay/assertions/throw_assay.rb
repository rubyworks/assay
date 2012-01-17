require_relative 'execution_assay'

#
class ThrowAssay < ExecutionAssay

  def self.operator
    :throw?
  end

  def self.assertive_name
    :throw
  end

  # Passes if the block throws expected_symbol
  #
  #   assert_throws :done do
  #     throw :done
  #   end
  #
  def pass?(sym, &block)
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
  def fail?(sym, &block)
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
  def message(*arguments)
    return @mesg if @mesg
    return super unless arguments.size == 1
  
    sym = arguments[0].inspect
  
    if @_negated
      "Expected #{sym} to have been thrown"
    else
      "Expected #{sym} NOT to have been thrown"
    end
  end

end
