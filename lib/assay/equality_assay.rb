require_relative 'equal_assay'

# EqualityAssay defines the assertion for the `#eql?`, the strict equality
# method.
#
class EqualityAssay < EqualAssay

  #
  def self.operator
    :eql?
  end

  #
  def self.assertive_name
    :eql
  end

  #
  # Check assertion via `#eql?` method.
  #
  def self.pass?(target, criterion)
    criterion.eql?(target)
  end

end

