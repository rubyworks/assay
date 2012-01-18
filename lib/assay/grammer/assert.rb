require 'assay/grammer'

class BasicObject

  # Use `assert` nomenclature for assertions.
  #
  #  10.assert.kind_of?(Integer)
  #
  def assert(matcher=nil)
    if matcher
      matcher === self
    else
      ::Assay::Grammer::Assert.new(self)
    end
  end

end

