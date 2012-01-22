require_relative 'match_assay'

# Ruby 1.9+ allows #!~ to redfined as it's own method, so a corresponding
# assay is required to cover it.
# 
class NoMatchAssay < MatchAssay

  #
  def self.operator
    :!~
  end

  #
  def self.assertive_name
    :nomatch
  end

  # Check assertion.
  def self.pass?(actual, criterion)
    criterion !~ actual
  end

  #
  def pass_message(actual)
    a = actual.inspect
    c = criteria.first.inspect

    if a.size > SIZE_LIMIT or c.size > SIZE_LIMIT
      "a !~ b\na) #{c}\nb) #{a}"
    else
      "#{c} !~ #{a}"
    end
  end

end
