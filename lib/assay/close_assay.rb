require_relative 'compare_assay'

# Relative approximation, sometimes refered to as *within epsilon*.
#
class CloseAssay < CompareAssay

  register :close

  #
  # Check assertion.
  #
  def self.pass?(subject, criterion, epsilon)
    #if [subject, criterion, epsilon].all?{ |v| Numeric === v }
      a, b, e = subject.to_f, criterion.to_f, epsilon.to_f
    #else
    #  a, b, e = subject, criterion, epsilon
    #end

    #(a - b).abs / [a.abs, b.abs].max <= e
    
    d = b * e   # [a.abs,b.abs].max * e

    (b - d) <= a && (b + d) >= a
  end

  #
  # Failed assertion message.
  #
  def self.assert_message(subject, criterion, delta)
    a = subject.inspect
    b = criterion.inspect
    e = delta.inspect

    if [a, b, e].any?{ |e| e.to_s.size > SIZE_LIMIT }
      "b(1 - e) <= a <= b(1 + e)\na) #{a}\nb) #{b}\nd) #{d}"
    else
      "#{b}(1 - #{e}) <= #{a} <= #{b}(1 + #{e})"
    end
  end

end

