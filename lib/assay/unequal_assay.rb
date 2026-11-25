require_relative 'equal_assay'

# UnequalAssay compares objects with `#!=` operator. Yes, as of Ruby 1.9
# the `!=` is a redefinable method, and as such, we need a separate
# assay to cover it.
#
class UnequalAssay < EqualAssay

  register :!=, :unequal

  #
  # Check assertion using `#!=` method.
  #
  def self.pass?(subject, criterion)
    subject != criterion
  end

  #
  # Failed assertion message.
  #
  def self.assert_message(subject, criterion)
    a = subject.inspect
    b = criterion.inspect
  
    if a.size > SIZE_LIMIT or b.size > SIZE_LIMIT
      if $ansi
        a, b = Assay.color_diff(a, b)
      end
      "a != b\na) #{a}\nb) #{b}"
    else
      "#{a} != #{b}"
    end
  end

end

