require 'test/unit'
require 'assay'
require 'assay/adapters/testunit'

class ExampleTest < Test::Unit::TestCase

  include Assay::Assertives

  def test_this
    assert_equal(1,2,"not this dingo!")
  end
end

