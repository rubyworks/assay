covers 'assay/equality_assay'

testcase EqualityAssay do

  class_method :pass? do

    test do
      assert EqualityAssay.pass?(1, 1)

      refute EqualityAssay.pass?(1, 1.0)
      refute EqualityAssay.pass?(1, 2)
    end

  end

  class_method :fail? do

    test do
      refute EqualityAssay.fail?(1, 1)

      assert EqualityAssay.fail?(1, 1.0)
      assert EqualityAssay.fail?(1, 2)
    end

  end

  class_method :assert! do

    test do
      EqualityAssay.assert!(1, 1)
    end

    test do
      expect EqualityAssay do
        EqualityAssay.assert!(1, 2)
      end
    end

  end

  class_method :refute! do

    test do
      EqualityAssay.refute!(1, 1.0)
    end

    test do
      expect EqualityAssay do
        EqualityAssay.refute!(1, 1)
      end
    end

  end

end
