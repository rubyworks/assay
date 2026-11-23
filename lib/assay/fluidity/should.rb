require_relative 'grammar'

class Object #BasicObject

  # Use `should` nomenclature for assertions.
  #
  #  10.should.be.kind_of(Integer)
  #
  def should(matcher=nil)
    if matcher
      matcher =~ self
    else
      ::Assay::Fluidity::Grammar::Should.new(self)
    end
  end

  # Also, `should_not` nomenclature for assertions.
  #
  #  10.should_not.be.kind_of?(Integer)
  #
  def should_not(matcher=nil)
    if matcher
      matcher !~ self
    else
      ::Assay::Fluidity::Grammar::Should.new(self, true)
    end
  end

  alias_method :shouldnt, :should_not

end

