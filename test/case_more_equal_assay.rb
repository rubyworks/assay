covers 'assay/more_equal_assay'

testcase MoreEqualAssay do

  class_method :pass? do

    test do
      assert MoreEqualAssay.pass?(2, 1)
      assert MoreEqualAssay.pass?(1, 1)
      refute MoreEqualAssay.pass?(1, 2)
    end

  end

  class_method :fail? do

    test do
      refute MoreEqualAssay.fail?(2, 1)
      refute MoreEqualAssay.fail?(1, 1)
      assert MoreEqualAssay.fail?(1, 2)
    end

  end

  class_method :assert! do

    test do
      MoreEqualAssay.assert!(2, 1)
    end

    test do
      expect MoreEqualAssay do
        MoreEqualAssay.assert!(1, 2)
      end
    end

  end

  class_method :refute! do

    test do
      MoreEqualAssay.refute!(1, 2)
    end

    test do
      expect MoreEqualAssay do
        MoreEqualAssay.refute!(2, 1)
      end
    end

  end

end
