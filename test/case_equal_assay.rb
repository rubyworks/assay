covers 'assay/equal_assay'

testcase EqualAssay do

  class_method :pass? do

    test do
      assert EqualAssay.pass?(1, 1)
      assert EqualAssay.pass?(1, 1.0)
      refute EqualAssay.pass?(1, 2)
    end

  end

  class_method :fail? do

    test do
      refute EqualAssay.fail?(1, 1)
      refute EqualAssay.fail?(1, 1.0)
      assert EqualAssay.fail?(1, 2)
    end

  end

  class_method :assert! do

    test do
      EqualAssay.assert!(1, 1)
    end

    test do
      expect EqualAssay do
        EqualAssay.assert!(1, 2)
      end
    end

  end

  class_method :refute! do

    test do
      EqualAssay.refute!(1, 2)
    end

    test do
      expect EqualAssay do
        EqualAssay.refute!(1, 1)
      end
    end

  end

end
