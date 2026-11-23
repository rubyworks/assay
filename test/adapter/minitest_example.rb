require 'assay'
require 'assay/adapter/minitest'
require 'minitest/autorun'

class AdapterExample < Minitest::Test
  def test_pass;        EqualAssay.assert!(1, 1); end
  def test_assay_fail;  EqualAssay.assert!(1, 2); end
  def test_native_fail; assert_equal 1, 2;        end
  def test_error;       raise "oops";             end
  def test_skip;        skip "later";             end
end
