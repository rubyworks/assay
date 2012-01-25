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

end

