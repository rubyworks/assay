covers 'assay/match_assay'

testcase MatchAssay do

  class_method :pass? do
    test do
      assert MatchAssay.pass?('a', /a/)
      refute MatchAssay.pass?('b', /a/)
      refute MatchAssay.pass?('a', /b/)
    end
  end

  class_method :fail? do
    test do
      refute MatchAssay.fail?('a', /a/)
      assert MatchAssay.fail?('b', /a/)
      assert MatchAssay.fail?('a', /b/)
    end
  end

  class_method :assert! do
    test do
      MatchAssay.assert!('a', /a/)
    end

    test do
      expect MatchAssay do
        MatchAssay.assert!('a', /b/)
      end
    end
  end

  class_method :refute! do
    test do
      MatchAssay.refute!('a', /b/)
    end

    test do
      expect MatchAssay do
        MatchAssay.refute!('a', /a/)
      end
    end
  end

end
