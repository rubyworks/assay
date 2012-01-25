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
  # Check assertion using `<=>`.
  #
  def self.pass?(subject, criterion, result=0)
    (subject <=> criterion) == result
  end

  #
  # Error message for campare assertion.
  #
  def self.assert_message(subject, criterion, result=0)
    a  = subject.inspect
    b  = criterion.inspect
    r  = result.inspect

    if a.size > SIZE_LIMIT or b.size > SIZE_LIMIT
      "a <=> b == #{r}\na) #{a}\nb) #{b}"
    else
      "#{a} <=> #{b} == #{r}"
    end
  end

end

