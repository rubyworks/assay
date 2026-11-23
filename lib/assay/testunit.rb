require_relative '../assay'

require_relative 'testunit/assertions'

# Test::Unit-compatible assertion methods (`assert_equal`, ...), to mix
# into a test scope.
module Assay::Assertions
  include Assay::TestUnit::Assertions
end
