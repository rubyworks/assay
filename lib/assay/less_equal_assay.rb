require_relative 'compare_assay'

# Compare assertion is used to test a comparision made by `#<=`.
#
# NOTE: We are taking some leeway here with the name of this class,
# which ordinarily would be called `LesserThanOrEqualAssay`.
# However, such a name is a bit winded. The shortest name then,
# without resorting to abbreviations, is _less-equal_, a monosyllabic
# reading of the operator itself. Since it is ordinarily meaningless
# to say something is "more equal" than something else, why not allow
# it to be meaningful and save ourselves all that uneccessary verbage?
#
class LessEqualAssay < CompareAssay

  register :<=, :less_equal

  #
  # Check assertion.
  #
  def self.pass?(subject, criterion)
    subject <= criterion
  end

end

