covers 'assay/throw_assay'

testcase ThrowAssay do

  class_method :pass? do

    test do
      assert ThrowAssay.pass?(:foo){ throw :foo }
      refute ThrowAssay.pass?(:foo){ throw :bar }
    end

  end

  class_method :fail? do

    test do
      assert ThrowAssay.fail?(:foo){ throw :bar }
      refute ThrowAssay.fail?(:foo){ throw :foo }
    end

  end

  class_method :assert! do

    test do
      ThrowAssay.assert!(:foo){ throw :foo }
    end

    test do
      expect ThrowAssay do
        ThrowAssay.assert!(:bar){ throw :foo }
      end
    end

  end

  class_method :refute! do

    test do
      ThrowAssay.refute!(:bar){ throw :foo }
    end

    test do
      expect ThrowAssay do
        ThrowAssay.refute!(:bar){ throw :bar }
      end
    end

  end

end
