require_relative '../assay'

require_relative 'rspec/matchers'
require_relative 'rspec/have'
require_relative 'rspec/should'
require_relative 'rspec/expect'
require_relative 'rspec/operatics'

# RSpec-compatible matcher methods (`eq`, `be_nil`, `expect`, ...), to mix
# into a test scope.
module Assay::Matchers
  include Assay::RSpec::Matchers
end
