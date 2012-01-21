covers 'assay/true_assay'

testcase TrueAssay do

  class_method :pass? do
    test do
      assert TrueAssay.pass?(true)
      refute TrueAssay.pass?(nil)
      refute TrueAssay.pass?(false)
      refute TrueAssay.pass?(:foobar)
    end
  end

  class_method :fail? do
    test do
      refute TrueAssay.fail?(true)
      assert TrueAssay.fail?(nil)
      assert TrueAssay.fail?(false)
      assert TrueAssay.fail?(:foobar)
    end
  end

  class_method :assert! do
    test do
      TrueAssay.assert!(true)
    end

    test do
      expect TrueAssay do
        TrueAssay.assert!(false)
      end
    end
  end

  class_method :refute! do
    test do
      TrueAssay.refute!(nil)
      TrueAssay.refute!(false)
    end

    test do
      expect TrueAssay do
        TrueAssay.refute!(true)
      end
    end
  end

end
