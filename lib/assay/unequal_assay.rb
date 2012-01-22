require_relative 'equal_assay'

# UnequalAssay compares objects with `#!=` operator. Yes, as of Ruby 1.9
# the `!=` is a redefinable method, and as such, we need a separate
# assay to cover it.
#
class UnequalAssay < EqualAssay

  #
  def self.operator
    :!=
  end

  #
  def self.assertive_name
    :unequal
  end

  #
  # Check assertion.
  #
  def self.pass?(act, exp)
    exp != act
  end

  #
  def pass_message(target)
    op = "!="

    t = target.inspect
    c = criteria.first.inspect
  
    if t.size > SIZE_LIMIT or c.size > SIZE_LIMIT
      diff = ANSI::Diff.new(c, t)
      "a != b\na) #{diff.diff1}\nb) #{diff.diff2}"
    else
      "#{c} != #{t}"
    end
  end

end

