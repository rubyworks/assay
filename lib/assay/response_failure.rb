require 'assay/execution_failure'

module Assay

  class ResponseFailure < ExecutionFailure

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
    def self.check(reciever, method)
      #flip = (Symbol === obj) && ! (Symbol === meth) # HACK for specs
      #obj, meth = meth, obj if flip
      reciever.respond_to?(method)
    end

    #
    def to_s
      return super unless @_arguments.size == 2

      receiver = @_arguments[0].inspect
      method   = @_arguments[1].inspect

      if @_negated
        "Expected #{reciever} (#{reciever.class}) to NOT respond to ##{method}"
      else
        "Expected #{reciever} (#{reciever.class}) to respond to ##{method}"
      end
    end

  end


  module Assertable
    # Passes if +object+ respond_to? +methods+.
    #
    #   assert_respond_to 'bugbear', :slice
    #
    def assert_respond_to(reciever, method, opts={})
      opts[:backtrace] ||= caller
      ResponseFailure.assert(reciever, method, opts)
    end
    alias_method :assert_responds_to, :assert_respond_to

    # Passes if +object+ does not respond_to? +methods+.
    #
    #   assert_not_respond_to 'bugbear', :slice
    #
    def assert_not_respond_to(reciever, method, opts={})
      opts[:backtrace] ||= caller
      ResponseFailure.assert!(reciever, method, opts)
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

