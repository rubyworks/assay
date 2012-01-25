require_relative 'match_assay'

# Ruby 1.9+ allows #!~ to redfined as it's own method, so a corresponding
# assay is required to cover it.
# 
class NoMatchAssay < MatchAssay

  register :!~, :nomatch

  #
  # Check no match assertion with `#!~` method.
  #
  def self.pass?(matcher, matchee)
    matcher !~ matchee
  end

end
