module Assay::RSpec

  # Operatics delegates operator based assertions for execpt.rb.
  #
  class Operatics < Object
    instance_methods.each{ |m| undef_method m if m.to_s =~ /^\W/ }

    #
    def initialize(target, negate=false)
      @target = target
      @negate = negate
    end

  private

    #
    def method_missing(op, *a, &b)
      super(op, *a, &b) if op.to_s =~ /^\w/

      if @negate
        refute!(op, *a, &b)
      else
        assert!(op, *a, &b)
      end
    end

    #
    def assert!(op, *a, &b)
      if assay = Assertion.by_operator(op)
        return assay.assert!(@target, *a, {:backtrace=>caller}, &b)
      else
        ::Kernel.assert(@target.__send__(op, *a, &b), ::Assertion, "#{@target.inspect} #{op} #{a.map{ |x| x.inspect }.join(', ')}", caller)
      end
    end

    #
    def refute!(op, *a, &b)
      if assay = Assertion.by_operator(op)
        return assay.refute!(@target, *a, {:backtrace=>caller}, &b)
      else
        ::Kernel.refute(@target.__send__(op, *a, &b), ::Assertion, "! #{@target.inspect} #{op} #{a.map{ |x| x.inspect }.join(', ')}", caller)
      end
    end

    #
    def generic?(op)
      @target.method(op).owner == ::Kernel
    end if ::Method.method_defined?(:owner)

    #
    def generic?(op)
      @target.method(op).to_s.include?('(Kernel)')
    end unless ::Method.method_defined?(:owner)

  end

end
