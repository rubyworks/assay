require_relative 'grammar'

class Object

  # Use `assert` nomenclature for assertions.
  #
  #  10.assert.kind_of?(Integer)
  #
  def assert(*args, &blk)
    return ::Assay::Fluidity::Grammar::Assert.new(self) if args.empty?

    matcher = args.first

    if ::Assay::Assertor === matcher
      matcher =~ self
    else
      super(*args, &blk)
    end
  end

end


module Kernel
  public :assert
  public :refute
end
