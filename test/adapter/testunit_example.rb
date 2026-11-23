require 'assay'
require 'assay/adapter/testunit'
require 'test/unit'

class AdapterExample < Test::Unit::TestCase
  def test_pass;        EqualAssay.assert!(1, 1); end
  def test_assay_fail;  EqualAssay.assert!(1, 2); end
  def test_native_fail; assert_equal 1, 2;        end
  def test_error;       raise "oops";             end
end
