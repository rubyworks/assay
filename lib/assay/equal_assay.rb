require_relative 'like_assay'

# EqualAssay coers the assertion comparing two objects with `#==` operator.
#
class EqualAssay < LikeAssay

  register :==, :equal

  #
  # Test assertion of `#==` method.
  #
  def self.pass?(subject, criterion)
    subject == criterion
  end

  #
  # Error message for equal assertion.
  #
  def self.assert_message(subject, criterion)
    a = subject.inspect
    b = criterion.inspect
  
    if a.size > SIZE_LIMIT or b.size > SIZE_LIMIT
      if $ansi
        d = ANSI::Diff.new(a, b)
        a, b = d.diff1, d.diff2  # *d.to_a
      end
      "a == b\na) #{a}\nb) #{b}"
    else
      "#{a} == #{b}"
    end
  end

end

