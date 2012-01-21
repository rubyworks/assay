require_relative 'compare_assay'

# Equality assertion compares actual to expected with `#==` operator.
#
class EqualityAssay < CompareAssay

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
  # Check negated condition.
  #
  def self.fail?(act, exp)
    exp != act
  end

  #
  def pass_message(target)
    op = "=="

    t = target.inspect
    c = criteria.first.inspect
  
    if t.size > SIZE_LIMIT or c.size > SIZE_LIMIT
      diff = ANSI::Diff.new(c, t)
      "a #{op} b\na) #{diff.diff1}\nb) #{diff.diff2}"
    else
      "#{c} #{op} #{t}"
    end
  end

  #
  def fail_message(target)
    op = "!="

    t = target.inspect
    c = criteria.first.inspect
  
    if t.size > SIZE_LIMIT or c.size > SIZE_LIMIT
      diff = ANSI::Diff.new(c, t)
      "a #{op} b\na) #{diff.diff1}\nb) #{diff.diff2}"
    else
      "#{c} #{op} #{t}"
    end
  end

end

