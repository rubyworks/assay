require_relative 'compare_assay'

#
# TODO: assertive_name just doesn't cut it.
# 
class MatchAssay < CompareAssay

  #
  def self.operator
    :=~
  end

  #
  def self.assertive_name
    :match
  end

  # Check assertion.
  def self.pass?(actual, criterion)
    criterion =~ actual
  end

  # Check negated assertion.
  def self.fail?(actual, criterion)
    criterion !~ actual
  end

  #
  def self.pass_message(actual, criterion)
    actual    = actual.inspect
    criterion = criterion.inspect

    if actual.size > SIZE_LIMIT or criterion.size > SIZE_LIMIT
      "a =~ b\na) #{criterion}\nb) #{actual}"
    else
      "#{criterion} =~ #{actual}"
    end
  end

  #
  def self.fail_message(actual, criterion)
    actual    = actual.inspect
    criterion = criterion.inspect

    if actual.size > SIZE_LIMIT or criterion.size > SIZE_LIMIT
      "a !~ b\na) #{criterion}\nb) #{actual}"
    else
      "#{criterion} !~ #{actual}"
    end
  end

end
