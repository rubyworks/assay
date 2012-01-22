require_relative 'equal_assay'

# EqualityAssay defines the assertion for the `#eql?`, the strict equality
# method.
#
class EqualityAssay < EqualAssay

  register :eql

  #
  # Check assertion via `#eql?` method.
  #
  def self.pass?(target, criterion)
    criterion.eql?(target)
  end

end

