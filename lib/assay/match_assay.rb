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

#  #
#  #
#  #
#  def pass_message(matcher)
#    a = matcher.inspect
#    b = criteria.first.inspect  # matchee
#
#    if a.size > SIZE_LIMIT or b.size > SIZE_LIMIT
#      "a =~ b\na) #{a}\nb) #{b}"
#    else
#      "#{a} =~ #{b}"
#    end
#  end

end
