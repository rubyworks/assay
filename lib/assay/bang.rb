require_relative '../assay'

module Assay

  # Bang turns query methods into assertions: call one with `!` in place
  # of `?` and it has to hold.
  #
  #   "string".instance_of!(String)
  #   "string".equal!("string")
  #   "string".not_equal!("another")
  #
  # Where Assay has a class for the assertion, a failure is an instance of
  # that class, here `InstanceAssay` and `EqualAssay`. Any other query
  # method an object has works too, and fails with a plain `Assertion`:
  #
  #   [].empty!            # EmptyAssay
  #   10.even!             # Assertion, by way of Integer#even?
  #
  # Nothing is defined ahead of time. A bang method that Ruby doesn't know
  # is looked up when it is called, so assay classes added later are
  # found, and real bang methods such as `String#upcase!` are never
  # touched.
  #
  module Bang

    # Bang names that differ from the assay's own name.
    NAMES = {
      :satisfy => :executes,
      :thrown  => :throw
    }

    #
    # Find the assay class for a bang name (less the `!` and any `not_`),
    # by name or by the query method it stands for. Returns nil if Assay
    # has none.
    #
    def self.lookup(name)
      name = NAMES[name.to_sym] || name.to_sym
      ::Assertion.by_name(name) || ::Assertion.by_operator(:"#{name}?")
    end

    #
    # Split a method name into the bare name and whether it is negated.
    # The name is nil unless it is a bang method. Always returns a pair:
    # destructuring a bare nil would ask nil for `to_ary`, and so come
    # back through `respond_to_missing?` without end.
    #
    def self.parse(method_name)
      name = method_name.to_s
      return [nil, false] unless name.end_with?('!') && name.size > 1
      name = name.chomp('!')
      if name.start_with?('not_') && name.size > 4
        [name[4..-1], true]
      else
        [name, false]
      end
    end

    # Included into Object.
    #
    module Methods

      #
      # Handle `foo!` and `not_foo!` by way of an assay class or the
      # object's own `foo?`.
      #
      def method_missing(method_name, *args, &block)
        name, negate = ::Assay::Bang.parse(method_name)

        return super unless name

        if assay = ::Assay::Bang.lookup(name)
          if negate
            assay.refute!(self, *args, {:backtrace=>caller}, &block)
          else
            assay.assert!(self, *args, {:backtrace=>caller}, &block)
          end
        elsif respond_to?("#{name}?")
          truth = __send__("#{name}?", *args, &block)
          call  = "#{inspect}.#{name}?"
          call += "(#{args.map{ |a| a.inspect }.join(', ')})" unless args.empty?
          if negate
            ::Kernel.refute(truth, ::Assertion, "! #{call}", caller)
          else
            ::Kernel.assert(truth, ::Assertion, call, caller)
          end
        else
          super
        end
      end

      #
      def respond_to_missing?(method_name, include_private=false)
        name, _ = ::Assay::Bang.parse(method_name)
        if name && (::Assay::Bang.lookup(name) || respond_to?("#{name}?"))
          true
        else
          super
        end
      end

    end

    # Included into Proc, for assertions about what calling it does.
    #
    module ProcMethods

      # Calling the procedure has to raise exactly this exception.
      def raises!(*exceptions)
        ::RaiseAssay.assert!(*exceptions, {:backtrace=>caller}, &self)
      end

      def not_raises!(*exceptions)
        ::RaiseAssay.refute!(*exceptions, {:backtrace=>caller}, &self)
      end

      # Calling the procedure has to raise this exception or a kind of it.
      def rescues!(*exceptions)
        ::RescueAssay.assert!(*exceptions, {:backtrace=>caller}, &self)
      end

      def not_rescues!(*exceptions)
        ::RescueAssay.refute!(*exceptions, {:backtrace=>caller}, &self)
      end

      # Calling the procedure has to throw this symbol.
      def throws!(symbol)
        ::ThrowAssay.assert!(symbol, {:backtrace=>caller}, &self)
      end

      def not_throws!(symbol)
        ::ThrowAssay.refute!(symbol, {:backtrace=>caller}, &self)
      end

    end

  end

end

class Object
  include Assay::Bang::Methods
end

class Proc
  include Assay::Bang::ProcMethods
end
