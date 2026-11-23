require_relative 'grammar'

class Object #BasicObject

  # Use `will` nomenclature for assertions.
  #
  #  10.will.be.kind_of(Integer)
  #
  def will(matcher=nil)
    if matcher
      matcher =~ self
    else
      ::Assay::Fluidity::Grammar::Will.new(self)
    end
  end

  # Also, `will_not` nomenclature for assertions.
  #
  #  10.will_not.be.kind_of?(Integer)
  #
  def will_not(matcher=nil)
    if matcher
      matcher !~ self
    else
      ::Assay::Fluidity::Grammar::Will.new(self, true)
    end
  end

  # Contraction of will not.
  #
  #  10.wont.be.kind_of?(Integer)
  #
  alias_method :wont, :will_not

end

