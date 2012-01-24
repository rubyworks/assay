require_relative 'assertion'

# Does an object #respond_to? a method call.
#
class RespondAssay < Assertion

  register :respond_to

  # Check assertion.
  def self.pass?(reciever, method_name)
    #flip = (Symbol === obj) && ! (Symbol === meth) # HACK for specs
    #obj, meth = meth, obj if flip
    reciever.respond_to?(method_name)
  end

#  #
#  def pass_message(receiver)
#    r = receiver.inspect
#    m = criteria.first.inspect  # method_name
#
#    if r.size > SIZE_LIMIT
#      "a.respond_to? b\na) (#{receiver.class}) #{r}\nb) ##{m}"
#    else
#      "(#{receiver.class}) #{r}.respond_to? ##{m}"
#    end
#  end

end

