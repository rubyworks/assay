covers 'assay/compare_assay'

testcase CompareAssay do

  class_method :pass? do

    test do
      assert CompareAssay.pass?(1, 1,  0)
      assert CompareAssay.pass?(1, 2, -1)
      assert CompareAssay.pass?(2, 1,  1)

      refute CompareAssay.pass?(1, 1,  1)
      refute CompareAssay.pass?(1, 1, -1)
    end

  end

  class_method :fail? do

    test do
      assert CompareAssay.fail?(1, 1,  1)
      assert CompareAssay.fail?(1, 1, -1)

      refute CompareAssay.fail?(1, 1,  0)
      refute CompareAssay.fail?(1, 2, -1)
      refute CompareAssay.fail?(2, 1,  1)
    end

  end

  class_method :assert! do

    test do
      CompareAssay.assert!(1, 1, 0)
    end

    test do
      expect CompareAssay do
        CompareAssay.assert!(1, 1, 1)
      end
    end

  end

  class_method :refute! do

    test do
      CompareAssay.refute!(1, 2, 0)
    end

    test do
      expect CompareAssay do
        CompareAssay.refute!(1, 1, 0)
      end
    end

  end

end
