covers 'assay/false_assay'

testcase FalseAssay do

  class_method :pass? do
    test do
      assert FalseAssay.pass?(false)
      refute FalseAssay.pass?(true)
      refute FalseAssay.pass?(nil)
      refute FalseAssay.pass?(:foobar)
    end
  end

  class_method :fail? do
    test do
      refute FalseAssay.fail?(false)
      assert FalseAssay.fail?(true)
      assert FalseAssay.fail?(nil)
      assert FalseAssay.fail?(:foobar)
    end
  end

  class_method :assert! do
    test do
      FalseAssay.assert!(false)
    end

    test do
      expect FalseAssay do
        FalseAssay.assert!(nil)
      end
    end
  end

  class_method :refute! do
    test do
      FalseAssay.refute!(true)
      FalseAssay.refute!(nil)
    end

    test do
      expect FalseAssay do
        FalseAssay.refute!(false)
      end
    end
  end

end
