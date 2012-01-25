require_relative 'compare_assay'

# TODO: Support Range for Delta comparisons.

#
class WithinAssay < CompareAssay

  register :within

  #
  # Check assertion.
  #
  def self.pass?(subject, criterion, delta)
    if [subject, criterion, delta].all?{ |v| Numeric === v }
      a, b, d = subject.to_f, criterion.to_f, delta.to_f
    else
      a, b, d = subject, criterion, delta
    end

    (b - d) <= a && (b + d) >= a
  end

  #
  # Failed assertion message.
  #
  def self.assert_message(subject, criterion, delta)
    a = subject.inspect
    b = criterion.inspect
    d = delta.inspect

    if [a, b, d].any?{ |e| e.size > SIZE_LIMIT }
      "b - d <= a <= b + d\na) #{a}\nb) #{b}\nd) #{d}"
    else
      "#{b} - #{d} <= #{a} <= #{b} + #{d}"
    end
  end

end

