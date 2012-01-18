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

  # Check assertion.
  def self.pass?(act, exp)
    exp == act
  end

  # Check negated assertion.
  def self.fail?(act, exp)
    exp != act
  end

  #
  def self.pass_message(act, exp)
    oper = "=="
    iact = act.inspect
    iexp = exp.inspect
  
    if iexp.size > SIZE_LIMIT or iact.size > SIZE_LIMIT
      diff = ANSI::Diff.new(iact, iexp)
      "a #{oper} b\na) #{diff.diff1}\nb) #{diff.diff2}"
    else
      "#{iact} #{oper} #{iexp}"
    end
  end

  #
  def self.fail_message(act, exp)
    oper = "!="
    iact = act.inspect
    iexp = exp.inspect
  
    if iexp.size > SIZE_LIMIT or iact.size > SIZE_LIMIT
      diff = ANSI::Diff.new(iact, iexp)
      "a #{oper} b\na) #{diff.diff1}\nb) #{diff.diff2}"
    else
      "#{iact} #{oper} #{iexp}"
    end

  end

end

