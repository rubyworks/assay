covers 'assay/kind_assay'

testcase KindAssay do

  class_method :pass? do

    test do
      assert KindAssay.pass?(1,Integer)
      refute KindAssay.pass?(1,String)
    end

  end

  class_method :fail? do

    test do
      refute KindAssay.fail?(1,Integer)
      assert KindAssay.fail?(1,String)
    end

  end

  class_method :assert! do

    test do
      KindAssay.assert!(1,Fixnum)
    end

    test do
      expect KindAssay do
        KindAssay.assert!(1,Symbol)
      end
    end

  end

  class_method :refute! do

    test do
      KindAssay.refute!(1,String)
    end

    test do
      expect KindAssay do
        KindAssay.refute!(1,Numeric)
      end
    end

  end

end
