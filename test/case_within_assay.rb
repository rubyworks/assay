covers 'assay/within_assay'

testcase WithinAssay do

  class_method :pass? do

    test do
      assert WithinAssay.pass?(1,   1,   0)
      assert WithinAssay.pass?(1,   1.1, 0.1)
      assert WithinAssay.pass?(1.0, 1.2, 0.2)

      refute WithinAssay.pass?(1,   2,   0.5)
      refute WithinAssay.pass?(1.0, 2,   0.5)
      refute WithinAssay.pass?(1.0, 2.0, 0.5)
    end

  end

  class_method :fail? do

    test do
      refute WithinAssay.fail?(1,   1,   0)
      refute WithinAssay.fail?(1,   1.1, 0.1)
      refute WithinAssay.fail?(1.0, 1.2, 0.2)

      assert WithinAssay.fail?(1,   2,   0.5)
      assert WithinAssay.fail?(1.0, 2,   0.5)
      assert WithinAssay.fail?(1.0, 2.0, 0.5)
    end

  end

  class_method :assert! do

    test do
      WithinAssay.assert!(1, 1.1, 0.1)
    end

    test do
      expect WithinAssay do
        WithinAssay.assert!(1, 1.2, 0.1)
      end
    end

  end

  class_method :refute! do

    test do
      WithinAssay.refute!(1, 2, 0.1)
    end

    test do
      expect WithinAssay do
        WithinAssay.refute!(1, 1.1, 0.1)
      end
    end

  end

end
