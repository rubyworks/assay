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
  def self.pass?(subject, criterion, result=0)
    (subject <=> criterion) == result
  end

  #
  def pass_message(subject)
    a  = subject.inspect
    b  = criteria[0].inspect
    r  = criteria[1].inspect

    if a.size > SIZE_LIMIT or b.size > SIZE_LIMIT
      "a <=> b == #{r}\na) #{a}\nb) #{b}"
    else
      "#{a} <=> #{b} == #{r}"
    end
  end

end

