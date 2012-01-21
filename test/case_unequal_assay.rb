covers 'assay/unequal_assay'

testcase UnequalAssay do

  class_method :pass? do

    test do
      assert UnequalAssay.pass?(1, 2)

      refute UnequalAssay.pass?(1, 1)
      refute UnequalAssay.pass?(1, 1.0)
    end

  end

  class_method :fail? do

    test do
      assert UnequalAssay.fail?(1, 1)
      assert UnequalAssay.fail?(1, 1.0)

      refute UnequalAssay.fail?(1, 2)
    end

  end

  class_method :assert! do

    test do
      UnequalAssay.assert!(1, 2)
    end

    test do
      expect UnequalAssay do
        UnequalAssay.assert!(1, 1)
      end
    end

  end

  class_method :refute! do

    test do
      UnequalAssay.refute!(1, 1)
    end

    test do
      expect UnequalAssay do
        UnequalAssay.refute!(1, 2)
      end
    end

  end

end
