require_relative 'assertion'

# Compare assertion serves primarily as a base class
# for other more specific comparison assertions.
#
# In itself it can be used to test a comparision
# made by #<=>.
#
class CompareAssay < Assertion

  # TODO: What about #cmp alias?

  register :<=>, :compare

  #
  # Check assertion.
  #
  def self.pass?(target, criterion, result=0)
    (criterion <=> target) == result
  end

  #
  def pass_message(target)
    t  = target.inspect
    c  = criteria[0].inspect
    r  = criteria[1].inspect

    if t.size > SIZE_LIMIT or c.size > SIZE_LIMIT
      "a <=> b == #{r}\na) #{c}\nb) #{t}"
    else
      "#{c} <=> #{t} == #{r}"
    end
  end

end

