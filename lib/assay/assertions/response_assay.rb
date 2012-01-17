require_relative 'assertion'

# Does an object #respond_to? a method call.
#
class ResponseAssay < Assertion

  #
  def self.operator
    :respond_to?
  end

  #
  def self.assertive_name
    :respond_to
  end

  # Check assertion.
  def pass?(reciever, method)
    #flip = (Symbol === obj) && ! (Symbol === meth) # HACK for specs
    #obj, meth = meth, obj if flip
    reciever.respond_to?(method)
  end

  #
  def message(*arguments)
    return @mesg if @mesg
    return super unless arguments.size == 2
  
    reciever = arguments[0].inspect
    method   = arguments[1].inspect
  
    if @_negated
      "Expected #{reciever} (#{reciever.class}) to NOT respond to ##{method}"
    else
      "Expected #{reciever} (#{reciever.class}) to respond to ##{method}"
    end
  end

end

