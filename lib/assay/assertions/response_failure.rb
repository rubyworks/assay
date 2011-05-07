require 'assay/assertion'

module Assay

  # Does an object #respond_to? a method call.
  class ResponseFailure < Assertion

    def self.assertion_name
      :respond_to
    end

    def self.assertion_name!
      :not_respond_to
    end

    def self.operator_name
      :respond_to?
    end

    # Check assertion.
    def self.pass?(reciever, method)
      #flip = (Symbol === obj) && ! (Symbol === meth) # HACK for specs
      #obj, meth = meth, obj if flip
      reciever.respond_to?(method)
    end

    #
    def to_s
      return @mesg if @mesg
      return super unless @arguments.size == 2

      reciever = @arguments[0].inspect
      method   = @arguments[1].inspect

      if @_negated
        "Expected #{reciever} (#{reciever.class}) to NOT respond to ##{method}"
      else
        "Expected #{reciever} (#{reciever.class}) to respond to ##{method}"
      end
    end

  end


  module Assertives
    # Passes if +object+ respond_to? +methods+.
    #
    #   assert_respond_to 'bugbear', :slice
    #
    def assert_respond_to(reciever, method, msg=nil)
      ResponseFailure.assert(reciever, method, :message=>msg, :backtrace=>caller)
    end
    alias_method :assert_responds_to, :assert_respond_to

    # Passes if +object+ does not respond_to? +methods+.
    #
    #   assert_not_respond_to 'bugbear', :slice
    #
    def assert_not_respond_to(reciever, method, msg=nil)
      ResponseFailure.refute(reciever, method, :message=>msg, :backtrace=>caller)
    end

    alias_method :assert_not_responds_to, :assert_not_respond_to
  end


  module Matchers
    #
    #
    #   object.assert is_responsive_to(:method_symbol)
    #
    def is_responsive_to(method)
      ResponseFailure.to_matcher(method)
    end

    #
    #
    #   object.should be_responsive_to(:method_symbol)
    #
    def be_responsive_to(method)
      ResponseFailure.to_matcher(method)
    end
  end

end

