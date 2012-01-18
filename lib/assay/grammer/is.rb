# TODO: What about BasicObject ?

class Object

  # Use `is` nomenclature for assertions.
  #
  #  10.is.kind_of?(Integer)
  #
  def is(matcher=nil)
    if matcher
      matcher === self
    else
      Assay::Grammer::Is.new(self)
    end
  end

end

