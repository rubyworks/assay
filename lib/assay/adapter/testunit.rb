require 'test/unit'

module Assay
  module Adapter

    # Teaches Test::Unit that any exception answering true to `assertion?`
    # (the BRASS standard) is a failed assertion, not an error. Without
    # this Test::Unit still runs tests that use Assay, but counts their
    # failures as errors.
    #
    # Loaded with `require 'assay/adapter/testunit'`. Needs the test-unit
    # gem, version 3 or newer.
    #
    module TestUnit

      def self.included(base)
        base.exception_handler(:handle_brass_assertion)
      end

      private

      def handle_brass_assertion(exception)
        return false if exception.is_a?(::Test::Unit::AssertionFailedError)
        return false unless exception.respond_to?(:assertion?) && exception.assertion?
        problem_occurred
        add_failure(exception.message, exception.backtrace)
        true
      end

    end

  end
end

Test::Unit::TestCase.send(:include, Assay::Adapter::TestUnit)
