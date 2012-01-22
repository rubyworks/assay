require_relative 'compare_assay'

# Compare assertion is used to test a comparision
# made by `#<`.
#
class LessAssay < CompareAssay

  register :<, :less_than

  #
  # Check assertion.
  #
  def self.pass?(target, criterion)
    target < criterion
  end

  #
  #
  #
  def pass_message(target)
    t  = target.inspect
    c  = criteria[0].inspect

    if t.size > SIZE_LIMIT or c.size > SIZE_LIMIT
      "a < b\na) #{t}\nb) #{c}"
    else
      "#{t} < #{c}"
    end
  end

end

