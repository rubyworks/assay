require_relative 'like_assay'

# EqualAssay coers the assertion comparing two objects with `#==` operator.
#
class EqualAssay < LikeAssay

  #
  def self.operator
    :==
  end

  #
  def self.assertive_name
    :equal
  end

  #
  # Check assertion.
  #
  def self.pass?(act, exp)
    exp == act
  end

  #
  def pass_message(target)
    op = "=="

    t = target.inspect
    c = criteria.first.inspect
  
    if t.size > SIZE_LIMIT or c.size > SIZE_LIMIT
      diff = ANSI::Diff.new(c, t)
      "a == b\na) #{diff.diff1}\nb) #{diff.diff2}"
    else
      "#{c} == #{t}"
    end
  end

end

