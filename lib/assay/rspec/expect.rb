module Assay::RSpec

  # Wraps the target of an expectation.
  #
  # @example
  #   expect(something) # => Expect
  #
  #   # used with `to`
  #   expect(actual).to eq(3)
  #
  #   # with `to_not`
  #   expect(actual).to_not eq(3)
  #
  class Expect

    # @api private
    def initialize(target)
      @target = target
    end

    # Runs the given expectation, passing if `matcher` returns true.
    #
    # @example
    #   expect(value).to eq(5)
    #   expect { perform }.to raise_error
    #
    # @param [Matcher]
    #   matcher
    #
    # @param [String] message optional message to display when the expectation fails
    #
    # @return [Boolean] true if the expectation succeeds (else raises)
    #
    # @see RSpec::Matchers
    #
    def to(matcher=nil, message=nil, &block)
      #prevent_operator_matchers(:to, matcher)
      handle_positive_matcher(@target, matcher, message, &block)
    end

    # Runs the given expectation, passing if `matcher` returns false.
    #
    # @example
    #   expect(value).to_not eq(5)
    #   expect(value).not_to eq(5)
    #
    # @param [Matcher]
    #   matcher
    #
    # @param [String] message optional message to display when the expectation fails
    #
    # @return [Boolean] false if the negative expectation succeeds (else raises)
    #
    # @see RSpec::Matchers
    #
    def to_not(matcher=nil, message=nil, &block)
      #prevent_operator_matchers(:to_not, matcher)
      handle_negative_matcher(@target, matcher, message, &block)
    end

    alias :not_to :to_not

  private

    #def prevent_operator_matchers(verb, matcher)
    #  return if matcher
    #
    #  raise ArgumentError, "The expect syntax does not support operator matchers, " +
    #                       "so you must pass a matcher to `##{verb}`."
    #end

    #
    # @todo how to customize the message?
    #
    def handle_positive_matcher(actual, matcher, message=nil, &block)
      check_message(message)

      #::RSpec::Matchers.last_should = :should
      #::RSpec::Matchers.last_matcher = matcher

      if block
        actual = block.call(actual)
      end

      #return ::RSpec::Matchers::BuiltIn::PositiveOperatorMatcher.new(actual) if matcher.nil?

      return Operatics.new(actual) if matcher.nil?

      matcher =~ actual

      #match = matcher.matches?(actual, &block)
      #return match if match

      #message ||= matcher.respond_to?(:failure_message_for_should) ?
      #            matcher.failure_message_for_should :
      #            matcher.failure_message

      #if matcher.respond_to?(:diffable?) && matcher.diffable?
      #  ::RSpec::Expectations.fail_with message, matcher.expected, matcher.actual
      #else
      #  ::RSpec::Expectations.fail_with message
      #end
    end

    #
    # @todo how to customize the message?
    #
    def handle_negative_matcher(actual, matcher, message=nil, &block)
      check_message(message)

      #::RSpec::Matchers.last_should = :should_not
      #::RSpec::Matchers.last_matcher = matcher

      if block
        actual = block.call(actual)
      end

      #return ::RSpec::Matchers::BuiltIn::NegativeOperatorMatcher.new(actual) if matcher.nil?

      return Operatics.new(actual, true) if matcher.nil?

      matcher !~ actual

      #match = matcher.respond_to?(:does_not_match?) ?
      #        !matcher.does_not_match?(actual, &block) :
      #        matcher.matches?(actual, &block)
      #return match unless match

      #message ||= matcher.respond_to?(:failure_message_for_should_not) ?
      #            matcher.failure_message_for_should_not :
      #            matcher.negative_failure_message

      #if matcher.respond_to?(:diffable?) && matcher.diffable?
      #  ::RSpec::Expectations.fail_with message, matcher.expected, matcher.actual
      #else
      #  ::RSpec::Expectations.fail_with message
      #end
    end

    def message_must_be_string(msg)
      "WARNING: ignoring the provided expectation message argument " +
      "(#{msg.inspect}) since it is not a string."
    end

    def check_message(msg)
      ::Kernel.warn message_must_be_string(msg) unless msg.nil? || msg.is_a?(String)
    end

  end

end
