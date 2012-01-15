require_realtive 'compare_assay'

# Equality assertion compares actual to expected with `#==` operator.
#
class EqualityAssay < CompareAssay

  #
  def self.assertion_name
    :equal
  end

  #
  def self.assertion_operator
    :==
  end

  # Check assertion.
  def self.pass?(act, exp)
    exp == act
  end

  # Check negated assertion.
  def self.fail?(act, exp)
    exp != act
  end

  #
  def to_s
    return @mesg if @mesg
    return super unless @arguments.size == 2

    oper = @_negated ? "!=" : "=="
    iexp = @arguments[0].inspect
    iact = @arguments[1].inspect

    if iexp.size > SIZE_LIMIT or iact.size > SIZE_LIMIT
      diff = ANSI::Diff.new(iact, iexp)
      "a #{oper} b\na) #{diff.diff1}\nb) #{diff.diff2}"
    else
      "#{iact} #{oper} #{iexp}"
    end
  end

end

