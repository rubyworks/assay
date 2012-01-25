require_relative 'compare_assay'

# Compare assertion is used to test a comparision
# made by `#>`.
#
class MoreAssay < CompareAssay

  register :>, :more_than

  #
  # Check assertion using `#>` method call.
  #
  def self.pass?(subject, criterion)
    subject > criterion
  end

end

