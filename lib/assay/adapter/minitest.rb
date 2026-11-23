require 'minitest'

module Assay
  module Adapter

    # Teaches Minitest that any exception answering true to `assertion?`
    # (the BRASS standard) is a failed assertion, not an error. Without
    # this Minitest still runs tests that use Assay, but counts their
    # failures as errors.
    #
    # Loaded with `require 'assay/adapter/minitest'`. Needs Minitest 5
    # or newer.
    #
    module Minitest

      def capture_exceptions
        super do
          begin
            yield
          rescue ::Minitest::Assertion, *::Minitest::Test::PASSTHROUGH_EXCEPTIONS
            raise
          rescue Exception => error
            raise unless error.respond_to?(:assertion?) && error.assertion?
            failure = ::Minitest::Assertion.new(error.message)
            failure.set_backtrace(error.backtrace)
            raise failure
          end
        end
      end

    end

  end
end

Minitest::Test.prepend(Assay::Adapter::Minitest)
