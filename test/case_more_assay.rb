covers 'assay/more_assay'

testcase MoreAssay do

  class_method :pass? do

    test do
      assert MoreAssay.pass?(2, 1)
      refute MoreAssay.pass?(1, 1)
      refute MoreAssay.pass?(1, 2)
    end

  end

  class_method :fail? do

    test do
      refute MoreAssay.fail?(2, 1)
      assert MoreAssay.fail?(1, 1)
      assert MoreAssay.fail?(1, 2)
    end

  end

  class_method :assert! do

    test do
      MoreAssay.assert!(2, 1)
    end

    test do
      expect MoreAssay do
        MoreAssay.assert!(1, 2)
      end
    end

  end

  class_method :refute! do

    test do
      MoreAssay.refute!(1, 2)
    end

    test do
      expect MoreAssay do
        MoreAssay.refute!(2, 1)
      end
    end

  end

end
