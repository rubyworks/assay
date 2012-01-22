require_relative 'match_assay'

# Ruby 1.9+ allows #!~ to redfined as it's own method, so a corresponding
# assay is required to cover it.
# 
class NoMatchAssay < MatchAssay

  register :!~, :nomatch

  #
  # Check no match assertion.
  #
  def self.pass?(matcher, matchee)
    matcher !~ matchee
  end

  #
  #
  #
  def pass_message(matcher)
    a = matcher.inspect
    b = criteria.first.inspect

    if a.size > SIZE_LIMIT or b.size > SIZE_LIMIT
      "a !~ b\na) #{a}\nb) #{b}"
    else
      "#{a} !~ #{b}"
    end
  end

end
