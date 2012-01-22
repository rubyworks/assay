require_relative 'equal_assay'

# UnequalAssay compares objects with `#!=` operator. Yes, as of Ruby 1.9
# the `!=` is a redefinable method, and as such, we need a separate
# assay to cover it.
#
class UnequalAssay < EqualAssay

  register :!=, :unequal

  #
  # Check assertion.
  #
  def self.pass?(subject, criterion)
    subject != criterion
  end

  #
  def pass_message(subject)
    a = subject.inspect
    b = criteria.first.inspect
  
    if a.size > SIZE_LIMIT or b.size > SIZE_LIMIT
      diff = ANSI::Diff.new(a, b)
      "a != b\na) #{diff.diff1}\nb) #{diff.diff2}"
    else
      "#{a} != #{b}"
    end
  end

end

