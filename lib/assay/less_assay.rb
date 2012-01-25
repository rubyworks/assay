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

end

