require_relative 'grammar'

class Object #BasicObject

  # Use `is` nomenclature for assertions.
  #
  #  10.is.kind_of?(Integer)
  #
  def is(matcher=nil)
    if matcher
      matcher === self
    else
      ::Assay::Fluidity::Grammar::Is.new(self)
    end
  end

end

