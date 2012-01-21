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
  def pass_message(actual, criterion)
    a = actual.inspect
    c = criterion.inspect

    if a.size > SIZE_LIMIT or c.size > SIZE_LIMIT
      "a =~ b\na) #{c}\nb) #{a}"
    else
      "#{c} =~ #{a}"
    end
  end

  #
  def self.fail_message(actual, criterion)
    a = actual.inspect
    c = criterion.inspect

    if a.size > SIZE_LIMIT or c.size > SIZE_LIMIT
      "a !~ b\na) #{c}\nb) #{a}"
    else
      "#{c} !~ #{a}"
    end
  end

end
