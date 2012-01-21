covers 'assay/respond_assay'

testcase RespondAssay do

  class_method :pass? do

    test do
      assert RespondAssay.pass?(:symbol, :to_s)
      refute RespondAssay.pass?(:symbol, :no_method)
    end

  end

  class_method :fail? do

    test do
      refute RespondAssay.fail?(:symbol, :to_s)
      assert RespondAssay.fail?(:symbol, :no_method)
    end

  end

  class_method :assert! do

    test do
      RespondAssay.assert!(:symbol, :to_s)
    end

    test do
      expect RespondAssay do
        RespondAssay.assert!(:symbol, :no_method)
      end
    end

  end

  class_method :refute! do

    test do
      RespondAssay.refute!(:symbol, :no_method)
    end

    test do
      expect RespondAssay do
        RespondAssay.refute!(:symbol, :to_s)
      end
    end

  end

end
