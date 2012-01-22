covers 'assay/less_assay'

testcase LessAssay do

  class_method :pass? do

    test do
      assert LessAssay.pass?(1, 2)
      refute LessAssay.pass?(1, 1)
      refute LessAssay.pass?(2, 1)
    end

  end

  class_method :fail? do

    test do
      refute LessAssay.fail?(1, 2)
      assert LessAssay.fail?(1, 1)
      assert LessAssay.fail?(2, 1)
    end

  end

  class_method :assert! do

    test do
      LessAssay.assert!(1, 2)
    end

    test do
      expect LessAssay do
        LessAssay.assert!(2, 1)
      end
    end

  end

  class_method :refute! do

    test do
      LessAssay.refute!(2, 1)
    end

    test do
      expect LessAssay do
        LessAssay.refute!(1, 2)
      end
    end

  end

end
