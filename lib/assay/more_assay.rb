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

  #
  # Error message, e.g. `5 > 3`.
  #
  def self.assert_message(subject, criterion)
    standard_message(subject, criterion)
  end

end
