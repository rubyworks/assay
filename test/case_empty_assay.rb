covers 'assay/empty_assay'

testcase EmptyAssay do

  class_method :pass? do

    test do
      assert EmptyAssay.pass?([])
      refute EmptyAssay.pass?([1])
    end

  end

  class_method :fail? do

    test do
      refute EmptyAssay.fail?([])
      assert EmptyAssay.fail?([1])
    end

  end

  class_method :assert! do

    test do
      EmptyAssay.assert!([])
    end

    test do
      expect EmptyAssay do
        EmptyAssay.assert!([1])
      end
    end

  end

  class_method :refute! do

    test do
      EmptyAssay.refute!([1])
    end

    test do
      expect EmptyAssay do
        EmptyAssay.refute!([])
      end
    end

  end

end
