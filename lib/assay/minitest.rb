require_relative '../assay'

require_relative 'minitest/assertions'
require_relative 'minitest/extensions'

module Assay
  # `Minitest` is how the framework spells its name now.
  Minitest = MiniTest unless const_defined?(:Minitest, false)
end

# Minitest-compatible assertion methods (`assert_equal`, ...), to mix
# into a test scope.
module Assay::Assertions
  include Assay::MiniTest::Assertions
end

# Minitest-compatible expectation methods (`must_equal`, ...).
module Assay::Extensions
  include Assay::MiniTest::Extensions
end

class Object
  include Assay::Extensions
end
