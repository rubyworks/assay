covers 'assay/nil_assay'

testcase NilAssay do

  class_method :pass? do
    test do
      assert NilAssay.pass?(nil)
      refute NilAssay.pass?(true)
      refute NilAssay.pass?(false)
      refute NilAssay.pass?(:foobar)
    end
  end

  class_method :fail? do
    test do
      refute NilAssay.fail?(nil)
      assert NilAssay.fail?(true)
      assert NilAssay.fail?(false)
      assert NilAssay.fail?(:foobar)
    end
  end

  class_method :assert! do
    test do
      NilAssay.assert!(nil)
    end

    test do
      expect NilAssay do
        NilAssay.assert!(false)
      end
    end
  end

  class_method :refute! do
    test do
      NilAssay.refute!(true)
      NilAssay.refute!(false)
    end

    test do
      expect NilAssay do
        NilAssay.refute!(nil)
      end
    end
  end

end
