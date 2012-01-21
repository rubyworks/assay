covers 'assay/include_assay'

testcase IncludeAssay do

  class_method :pass? do

    test do
      assert IncludeAssay.pass?([1], 1)
      refute IncludeAssay.pass?([1], 2)
    end

  end

  class_method :fail? do

    test do
      refute IncludeAssay.fail?([1], 1)
      assert IncludeAssay.fail?([1], 2)
    end

  end

  class_method :assert! do

    test do
      IncludeAssay.assert!([1], 1)
    end

    test do
      expect IncludeAssay do
        IncludeAssay.assert!([1], 2)
      end
    end

  end

  class_method :refute! do

    test do
      IncludeAssay.refute!([1], 2)
    end

    test do
      expect IncludeAssay do
        IncludeAssay.refute!([1], 1)
      end
    end

  end

end
