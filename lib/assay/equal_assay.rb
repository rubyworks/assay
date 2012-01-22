require_relative 'like_assay'

# EqualAssay coers the assertion comparing two objects with `#==` operator.
#
class EqualAssay < LikeAssay

  register :==, :equal

  #
  # Check assertion.
  #
  def self.pass?(subject, criterion)
    subject == criterion
  end

  #
  #
  #
  def pass_message(subject)
    a = subject.inspect
    b = criteria.first.inspect
  
    if a.size > SIZE_LIMIT or b.size > SIZE_LIMIT
      diff = ANSI::Diff.new(a, b)
      "a == b\na) #{diff.diff1}\nb) #{diff.diff2}"
    else
      "#{a} == #{b}"
    end
  end

end

