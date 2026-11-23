covers 'assay/raise_assay'

testcase RaiseAssay do

  class_method :pass? do

    test do
      assert RaiseAssay.pass?(StandardError){ raise StandardError }
      refute RaiseAssay.pass?(ArgumentError){ raise }
    end

  end

  class_method :fail? do

    test do
      refute RaiseAssay.fail?(StandardError){ raise StandardError }
      assert RaiseAssay.fail?(ArgumentError){ raise }
    end

  end

  class_method :assert! do

    test do
      RaiseAssay.assert!(StandardError){ raise StandardError }
    end

    test do
      expect RaiseAssay do
        RaiseAssay.assert!(ArgumentError){ raise }
      end
    end

  end

  class_method :refute! do

    test do
      RaiseAssay.refute!(ArgumentError){ raise }
    end

    test do
      expect RaiseAssay do
        RaiseAssay.refute!(StandardError){ raise StandardError }
      end
    end

  end

end
