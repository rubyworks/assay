covers 'assay/nomatch_assay'

testcase NoMatchAssay do

  class_method :pass? do
    test do
      assert NoMatchAssay.pass?('b', /a/)
      assert NoMatchAssay.pass?('a', /b/)

      refute NoMatchAssay.pass?('a', /a/)
    end
  end

  class_method :fail? do
    test do
      refute NoMatchAssay.fail?('b', /a/)
      refute NoMatchAssay.fail?('a', /b/)

      assert NoMatchAssay.fail?('a', /a/)
    end
  end

  class_method :assert! do
    test do
      NoMatchAssay.assert!('a', /b/)
    end

    test do
      expect NoMatchAssay do
        NoMatchAssay.assert!('a', /a/)
      end
    end
  end

  class_method :refute! do
    test do
      NoMatchAssay.refute!('a', /a/)
    end

    test do
      expect NoMatchAssay do
        NoMatchAssay.refute!('a', /b/)
      end
    end
  end

end
