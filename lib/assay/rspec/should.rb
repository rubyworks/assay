module Assay::RSpec

  # The Should module is included into BasicObject to provide 
  # the needed assertion interface that RSpec utilizes. Namely, the
  # `should` and `should_not` methods.
  #
  module Should

    #
    # Use `should` nomenclature for assertions.
    #
    #  10.should be_kind_of(Integer)
    #
    def should(matcher)
      matcher =~ self
    end

    #
    # Also, `should_not` nomenclature for assertions.
    #
    #  10.should_not be_kind_of?(Integer)
    #
    def should_not(matcher)
      matcher !~ self
    end

    #
    #
    # 
    def should=(value)
      EqualAssay.assert!(self, value)
    end

    #
    #
    #
    def should_not=(value)
      EqualAssay.refute!(self, value)
    end

  end

end


class BasicObject  # Object ?
  include ::Assay::RSpec::Should
end

