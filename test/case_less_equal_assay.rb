covers 'assay/less_equal_assay'

testcase LessEqualAssay do

  class_method :pass? do

    test do
      assert LessEqualAssay.pass?(1, 2)
      assert LessEqualAssay.pass?(1, 1)
      refute LessEqualAssay.pass?(2, 1)
    end

  end

  class_method :fail? do

    test do
      refute LessEqualAssay.fail?(1, 2)
      refute LessEqualAssay.fail?(1, 1)
      assert LessEqualAssay.fail?(2, 1)
    end

  end

  class_method :assert! do

    test do
      LessEqualAssay.assert!(1, 2)
    end

    test do
      expect LessEqualAssay do
        LessEqualAssay.assert!(2, 1)
      end
    end

  end

  class_method :refute! do

    test do
      LessEqualAssay.refute!(2, 1)
    end

    test do
      expect LessEqualAssay do
        LessEqualAssay.refute!(1, 2)
      end
    end

  end

end
