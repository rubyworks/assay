covers 'assay/instance_assay'

testcase InstanceAssay do

  class_method :pass? do

    test do
      assert InstanceAssay.pass?(1,Fixnum)
      refute InstanceAssay.pass?(1,Integer)
    end

  end

  class_method :fail? do

    test do
      refute InstanceAssay.fail?(1,Fixnum)
      assert InstanceAssay.fail?(1,String)
    end

  end

  class_method :assert! do

    test do
      InstanceAssay.assert!(1,Fixnum)
    end

    test do
      expect InstanceAssay do
        InstanceAssay.assert!(1,Symbol)
      end
    end

  end

  class_method :refute! do

    test do
      InstanceAssay.refute!(1,Numeric)
    end

    test do
      expect InstanceAssay do
        InstanceAssay.refute!(1,Fixnum)
      end
    end

  end

end
