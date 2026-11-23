require_relative 'compare_assay'

# Compare assertion is used to test a comparision
# made by `#<`.
#
class LessAssay < CompareAssay

  register :<, :less_than

  #
  # Check assertion.
  #
  def self.pass?(subject, criterion)
    subject < criterion
  end

  #
  # Error message, e.g. `5 < 3`.
  #
  def self.assert_message(subject, criterion)
    standard_message(subject, criterion)
  end

end
