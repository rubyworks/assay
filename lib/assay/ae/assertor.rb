require_relative '../../assay'
require_relative 'core_ext'

module Assay; end
module Assay::AE

  # Assertor is the class behind the AE notation. It is an *assertion
  # functor*, a higher-order function: it takes whatever method is called
  # on it, calls that method on the object under test, and asserts the
  # result.
  #
  #   x.assert == y        # Assertor.new(x) receives `==`
  #
  # It is built on BasicObject, so that the methods every object has
  # (`kind_of?`, `nil?`, `respond_to?`) are assertions too.
  #
  # When Assay has a class for the method, by its operator, a failure is
  # raised as that class: `x.assert == y` fails with an EqualAssay. Any
  # other method fails with a plain Assertion.
  #
  class Assertor < ::BasicObject

    # Initial settings of assertion counts.
    ZERO_COUNTS = {:total=>0, :pass=>0, :fail=>0}

    # AE's own query methods, and the Assay class each one fails with.
    # Methods that are an Assay class's operator need no entry.
    ASSAYS = {
      :eq?         => :EqualAssay,
      :case?       => :CaseAssay,
      :match?      => :MatchAssay,
      :equal?      => :IdentityAssay,
      :in_delta?   => :WithinAssay,
      :in_epsilon? => :CloseAssay,
      :raises?     => :RescueAssay,
      :raised?     => :RescueAssay,
      :throws?     => :ThrowAssay,
      :thrown?     => :ThrowAssay
    }

    # Returns the Hash used to track assertion counts. It is the global
    # `$ASSERTION_COUNTS`, which every notation adds to.
    def self.counts
      $ASSERTION_COUNTS
    end

    # Reset assertion counts.
    #
    # reset - Hash which can be used to set counts manually (optional).
    #
    # Returns the Hash of previous counts.
    def self.recount(reset=nil)
      old_counts = counts.dup
      if reset
        reset.each do |type, value|
          counts[type.to_sym] = value
        end
      else
        counts.replace(ZERO_COUNTS.dup)
      end
      return old_counts
    end

    # Increment assertion counts. If +pass+ is +true+ then +:total+
    # and +:pass+ are increased. If +pass+ if +false+ then +:total+
    # and +:fail+ are incremented.
    def self.increment_counts(pass)
      counts[:total] += 1
      if pass
        counts[:pass] += 1
      else
        counts[:fail] += 1
      end
      return counts
    end

    # Basic assertion. This method by-passes all the Assertor fluent
    # constructs and performs the underlying assertion procedure. It
    # is used by Assertor as the end call of an assertion.
    #
    # The +error+ can be a message, an exception, or a Proc that
    # returns either. A Proc is only called if the assertion fails,
    # which saves building a message that is never shown.
    #
    # The +assay+ is the class of exception to raise for a message. It
    # defaults to Assertion.
    def self.assert(pass, error=nil, negated=nil, backtrace=nil, assay=nil)
      pass = !!negated ^ !!pass
      increment_counts(pass)
      if !pass
        backtrace = backtrace || ::Kernel.caller
        raise_assertion(error, negated, backtrace, assay)
      end
      return pass
    end

    # Raise an assertion failure.
    def self.raise_assertion(error, negated, backtrace=nil, assay=nil)
      error = error.call if ::Proc === error
      if not ::Exception === error
        error = (assay || assertion_error).new(error)
      end
      error.set_negative(negated)
      error.set_backtrace(backtrace || ::Kernel.caller)
      error.set_assertion(true)
      ::Kernel.raise error
    end

    # Returns the Exception class raised when an assertion fails and no
    # Assay class covers it.
    def self.assertion_error
      ::Assertion
    end

    # The Assay class for a method name, if there is one.
    def self.assay_for(sym)
      if name = ASSAYS[sym]
        ::Object.const_get(name)
      else
        ::Assertion.by_operator(sym)
      end
    end

    # BasicObject has a few public methods of its own, which would
    # answer a call themselves instead of making an assertion. Making
    # these private sends them through #method_missing like any other
    # method, so `x.assert.instance_eval { @a == 1 }` asserts something
    # about `x`. Only #__send__ and #__id__ stay public, because Ruby
    # relies on them.
    private :==, :!, :!=, :equal?, :instance_eval, :instance_exec

    # Methods with no arguments whose result is not true, false or nil
    # get a warning, once per line, because the result is probably
    # meant to be compared, as in `x.assert.size == 3`. That compares
    # the assertion's own result, true, and checks nothing.
    def self.chain_warning(where, message)
      @chain_warnings ||= {}
      return if @chain_warnings[where]
      @chain_warnings[where] = true
      ::Kernel.warn("#{where}: warning: #{message}")
    end

    # Color diffs are skipped when the two strings are this large
    # (the product of their lengths), because building one takes
    # time and memory in proportion.
    DIFF_LIMIT = 1_000_000

    # New Assertor.
    #
    def initialize(delegate, opts={})
      @delegate  = delegate
      @message   = opts[:message]
      @backtrace = opts[:backtrace] || ::Kernel.caller
      @negated   = !!opts[:negated]
    end

    # Negate the meaning of the assertion.
    #
    def not(msg=nil)
      @negated = !@negated
      @message = msg if msg
      self
    end

    # Internal assert, provides all functionality associated
    # with external #assert method. (See Assert#assert)
    #
    # Returns +true+ or +false+ based on assertions success.
    #
    def assert(*args, &block)
      return self if !block && args.empty?

      # Block
      if block
        result = block.arity > 0 ? block.call(@delegate) : block.call
        if args.empty?
          return __assert__(result) { @message || block.inspect }
        else
          # Any expected value counts, even false or nil.
          match = args.shift
          return __assert__(match == result) { @message || "#{__inspect__(match)} == #{__inspect__(result)}" }
        end
      end

      target = args.shift

      # Assay matchers, such as `EqualAssay[10]`
      if ::Assay::Assertor === target
        return @negated ? (target !~ @delegate) : (target =~ @delegate)

      # Proc-style
      elsif proc_assertion?(target)
        pass, error = proc_apply(target)

      # RSpec-style matchers
      elsif rspec_matcher?(target)
        pass, error = rspec_matcher_apply(target)

      # Truthiness
      else
        pass  = target     # truthiness
        error = args.shift # optional message for TestUnit compatiability
      end

      __assert__(pass, error)
    end

    # Internal expect, provides all functionality associated
    # with external #expect method. (See Expect#expect)
    #
    def expect(*args, &block)
      return self if !block && args.empty?  # same as #assert

      pass  = false
      error = nil
      assay = nil

      if block
        # Any expected value counts, even false or nil.
        match = args.empty? ? @delegate : args.shift
        if exception?(match)
          # An exception instance stands for its class.
          klass = ::Class === match ? match : match.class
          assay = ::RescueAssay
          $DEBUG, debug = false, $DEBUG  # b/c it always spits-out a NameError
          begin
            block.arity > 0 ? block.call(@delegate) : block.call
            pass  = false
            error = "#{klass} not raised"
          rescue klass
            pass  = true
            error = "#{klass} raised"
          rescue ::SignalException, ::SystemExit, ::NoMemoryError
            ::Kernel.raise
          rescue ::Exception => e
            pass  = false
            error = "#{klass} expected but #{e.class} was raised: #{e.message}"
          ensure
            $DEBUG = debug
          end
          error = @message || error
        else
          result = block.arity > 0 ? block.call(@delegate) : block.call
          pass   = (match === result)
          assay  = ::CaseAssay
          error  = ::Kernel.proc { @message || "#{__inspect__(match)} === #{__inspect__(result)}" }
        end

      # Case Equality
      else
        target = args.shift
        pass   = (target === @delegate)
        assay  = ::CaseAssay
        error  = ::Kernel.proc { @message || "#{__inspect__(target)} === #{__inspect__(@delegate)}" }
      end

      __assert__(pass, error, assay)
    end

    # Fail, whether or not the assertion is negated.
    def flunk(message=nil, backtrace=nil)
      Assertor.assert(false, message || @message, false, backtrace || @backtrace)
    end

    # Without this Ruby skips #method_missing for `=~`.
    def =~(match)
      method_missing(:"=~", match)
    end

    #
    def send(op, *a, **kw, &b)
      method_missing(op, *a, **kw, &b)
    end

    #
    def inspect
      @delegate.inspect
    end

   private

    # Is `target` a Proc, or any other object that responds to #call?
    # A Hash or Symbol is a value like any other, even though it has
    # #to_proc.
    def proc_assertion?(target)
      ::Proc === target || target.respond_to?(:call)
    end

    #
    def proc_apply(target)
      arity = (::Proc === target || ::Method === target) ? target.arity : target.method(:call).arity
      pass  = arity != 0 ? target.call(@delegate) : target.call
      error = ::Kernel.proc {
        @message || (
          to_s = target.method(:to_s)
          to_s.arity == 0 ? to_s.call : to_s.call(@negated)
        )
      }
      return pass, error
    end

    # Is `target` an RSpec-style matcher?
    def rspec_matcher?(target)
      target.respond_to?(:matches?)
    end

    #
    def rspec_matcher_apply(matcher)
      pass  = matcher.matches?(@delegate)
      error = ::Kernel.proc { @message || rspec_matcher_message(matcher) }
      return pass, error
    end

    #
    def rspec_matcher_message(matcher)
      if @negated
        if matcher.respond_to?(:failure_message_when_negated)
          return matcher.failure_message_when_negated
        end
        if matcher.respond_to?(:failure_message_for_should_not)
          return matcher.failure_message_for_should_not
        end
        if matcher.respond_to?(:negative_failure_message)
          return matcher.negative_failure_message
        end
      end

      if matcher.respond_to?(:failure_message)
        return matcher.failure_message
      end
      if matcher.respond_to?(:failure_message_for_should)
        return matcher.failure_message_for_should
      end

      return matcher.to_s
    end

    # Is the +object+ an Exception class or an instance of one?
    def exception?(object)
      ::Exception === object || (::Class === object && object <= ::Exception)
    end

    # Converts a missing method into an assertion: the method is called
    # on the object under test and its result asserted.
    #
    # If the object has no such method but Assay has an assertion by
    # that operator or name (`x.assert.like?(y)`, `x.assert.kind_of(K)`),
    # the Assay class makes the test.
    def method_missing(sym, *args, **kw, &block)
      assay = Assertor.assay_for(sym)

      if !__responds__?(sym) && (found = assay || ::Assertion.by_name(sym))
        assay = found
        list  = kw.empty? ? args : args + [kw]
        pass  = assay.pass?(@delegate, *list, &block)
      else
        pass = @delegate.__send__(sym, *args, **kw, &block)

        if args.empty? && kw.empty? && !block
          __chain_warning__(sym, pass)
        end
      end

      __assert__(pass, nil, assay) do
        @message || compare_message(sym, *args) || generic_message(sym, *args, **kw)
      end
    end

    # Does the object under test have the method, public or not? An
    # object that can't say is taken to have it.
    def __responds__?(sym)
      @delegate.respond_to?(sym, true)
    rescue ::NoMethodError
      true
    end

    # Simple assert. The failure message can be given as a block,
    # which is only called if the assertion fails.
    def __assert__(pass, error=nil, assay=nil, &message)
      Assertor.assert(pass, error || message, @negated, @backtrace, assay)
    end

    # Warn about `x.assert.size == 3`, which checks only that `size`
    # is truthy. See Assertor.chain_warning.
    def __chain_warning__(sym, result)
      return if ::TrueClass === result || ::FalseClass === result || ::NilClass === result
      name = sym.to_s
      return unless /\A[a-z_]\w*\z/i.match?(name)
      where = @backtrace.first.to_s.sub(/:in .*\z/, '')
      value = __inspect__(result)
      value = value[0, 40] + '...' if value.size > 43
      Assertor.chain_warning(where,
        "`#{name}` returned #{value}, so only its truthiness was checked. " \
        "To compare the result, write `object.#{name}.assert == expected`."
      )
    end

    # The object's #inspect, or a plain description of it if #inspect
    # is missing or broken. A failure message shouldn't fail itself.
    def __inspect__(object)
      object.inspect
    rescue ::StandardError
      ::Kernel.instance_method(:to_s).bind_call(object)
    end

    #
    COMPARISON_OPERATORS = { :"==" => :"!=" }

    # Message to use when making a comparion assertion. With
    # `Assay.color = true`, long values are shown with their differences
    # colored.
    #
    # @param operator [Symbol] operator/method
    def compare_message(operator, *args, &blk)
      return nil unless COMPARISON_OPERATORS.key?(operator)
      a, b = __inspect__(@delegate), __inspect__(args.first)
      operator = COMPARISON_OPERATORS[operator] if @negated
      if a.size > 13 or b.size > 13
        if defined?($ansi) && $ansi && a.size * b.size <= DIFF_LIMIT
          a, b = ::Assay.color_diff(a, b)
        end
        "a #{operator} b\na) " + a + "\nb) " + b
      else
        "#{a} #{operator} #{b}"
      end
    end

    # Puts together a suitable error message.
    #
    # @param op [Symbol] operator/method
    #
    # @return [String] message
    def generic_message(op, *a, **kw, &b)
      inspection = __inspect__(@delegate)
      list = a.map { |x| __inspect__(x) } + kw.map { |k, v| "#{k}: #{__inspect__(v)}" }
      if @negated
        "! #{inspection} #{op} #{list.join(',')}"
      else
        "#{inspection} #{op} #{list.join(',')}"
      end
    end

    # @see http://redmine.ruby-lang.org/issues/3768
    def self.const_missing(const)
     ::Object.const_get(const)
    end
  end

end

# Copyright (c) 2008 Thomas Sawyer
