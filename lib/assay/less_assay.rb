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
  #
  #
  def pass_message(subject)
    a  = subject.inspect
    b  = criteria[0].inspect

    if a.size > SIZE_LIMIT or b.size > SIZE_LIMIT
      "a < b\na) #{a}\nb) #{b}"
    else
      "#{a} < #{b}"
    end
  end

end

