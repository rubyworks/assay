require_relative 'like_assay'

#
#
# 
class MatchAssay < LikeAssay

  register :=~, :match

  #
  # Check assertion for `#=~` method.
  #
  def self.pass?(matcher, matchee)
    matcher =~ matchee
  end

end
