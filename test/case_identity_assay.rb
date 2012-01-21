covers 'assay/identity_assay'

testcase IdentityAssay do

  class_method :pass? do

    test do
      assert IdentityAssay.pass?(1,1)
      refute IdentityAssay.pass?(1,2)
    end

  end

  class_method :fail? do

    test do
      refute IdentityAssay.fail?(1,1)
      assert IdentityAssay.fail?(1,2)
    end

  end

  class_method :assert! do

    test do
      IdentityAssay.assert!(1,1)
    end

    test do
      expect IdentityAssay do
        IdentityAssay.assert!(1,2)
      end
    end

  end

  class_method :refute! do

    test do
      IdentityAssay.refute!(1,2)
    end

    test do
      expect IdentityAssay do
        IdentityAssay.refute!(1,1)
      end
    end

  end

end
