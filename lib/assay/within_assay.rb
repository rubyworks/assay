require_relative 'compare_assay'

# TODO: Support Range for Delta comparisons.

#
class WithinAssay < CompareAssay

  register :within

  #
  # Check assertion.
  #
  def self.pass?(subject, criterion, delta)
    case delta
    when Numeric
      a = subject.to_f
      c = criterion.to_f
      d = delta.to_f

      (c - d) <= a && (c + d) >= a
    else
      a = subject
      c = criterion
      d = delta

      (c - d) <= a && (c + d) >= a
    end
  end

  #
  def pass_message(subject)
    x = subject.inspect
    y = criteria[0].inspect
    d = criteria[1].inspect

    if [x, y, d].any?{ |e| e.size > SIZE_LIMIT }
      "y - d <= x <= y + d\nx) #{x}\ny) #{y}\nd) #{d}"
    else
      "#{y} - #{d} <= #{x} <= #{x} + #{d}"
    end
  end

  #
  #def self.fail_message(subject, criterion, delta)
  #  "! " + pass_message(subject, criterion, delta)
  #end

end

