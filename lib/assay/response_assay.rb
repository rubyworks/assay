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
  def self.pass?(reciever, method)
    #flip = (Symbol === obj) && ! (Symbol === meth) # HACK for specs
    #obj, meth = meth, obj if flip
    reciever.respond_to?(method)
  end

  #
  def self.pass_message(receiver, method)
    ireceiver = receiver.inspect
    imethod   = method.inspect

    if ireceiver.size > SIZE_LIMIT
      "a.respond_to? b\na) (#{receiver.class}) #{ireceiver}\nb) ##{imethod}"
    else
      "(#{receiver.class}) #{ireceiver}.respond_to? ##{imethod}"
    end
  end

end

