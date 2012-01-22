require_relative 'compare_assay'

# Compare assertion is used to test a comparision made by `#>=`.
#
# NOTE: We are taking some leeway here with the name of this class,
# which ordinarily would be called `GreaterThanOrEqualAssay`.
# However, such a name is a bit winded. The shortest name then,
# without resorting to abbreviations, is _more-equal_, a monosyllabic
# reading of the operator itself. Since it is ordinarily meaningless
# to say something is "more equal" than something else, why not allow
# it to be meaningful and save ourselves all that uneccessary verbage?
#
class MoreEqualAssay < CompareAssay

  register :>=, :more_equal

  #
  # Check assertion.
  #
  def self.pass?(subject, criterion)
    subject >= criterion
  end

  #
  #
  #
  def pass_message(subject)
    a  = subject.inspect
    b  = criteria[0].inspect

    if a.size > SIZE_LIMIT or b.size > SIZE_LIMIT
      "a >= b\na) #{a}\nb) #{b}"
    else
      "#{a} >= #{b}"
    end
  end

end

