require_relative 'compare_assay'

# TODO: Support Range for Delta comparisons.

#
class WithinAssay < CompareAssay

  register :within

  #
  # Check assertion.
  #
  def self.pass?(subject, criterion, delta)
    if Numeric === delta
      subject   = subject.to_f
      criterion = criterion.to_f
      delta     = delta.to_f
    end

    a, c, d = subject, criterion, delta

    (c - d) <= a && (c + d) >= a
  end

  #
  # Failed assertion message.
  #
  def self.assert_message(subject)
    x = subject.inspect
    y = criteria[0].inspect
    d = criteria[1].inspect

    if [x, y, d].any?{ |e| e.size > SIZE_LIMIT }
      "y - d <= x <= y + d\nx) #{x}\ny) #{y}\nd) #{d}"
    else
      "#{y} - #{d} <= #{x} <= #{x} + #{d}"
    end
  end

end

