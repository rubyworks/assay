covers 'assay/like_assay'

testcase LikeAssay do

  class_method :pass? do

    test do
      assert LikeAssay.pass?(1, 1)
      assert LikeAssay.pass?(1, 1.0)
      assert LikeAssay.pass?(1, Integer)

      refute LikeAssay.pass?(1, 2)
    end

  end

  class_method :fail? do

    test do
      refute LikeAssay.fail?(1, 1)
      refute LikeAssay.fail?(1, 1.0)
      refute LikeAssay.fail?(1, Integer)

      assert LikeAssay.fail?(1, 2)
    end

  end

  class_method :assert! do

    test do
      LikeAssay.assert!(1, Numeric)
    end

    test do
      expect LikeAssay do
        LikeAssay.assert!(1, 2)
      end
    end

  end

  class_method :refute! do

    test do
      LikeAssay.refute!(1, 2)
    end

    test do
      expect LikeAssay do
        LikeAssay.refute!(1, 1)
      end
    end

  end

end
