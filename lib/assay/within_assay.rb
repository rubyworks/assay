require_relative 'compare_assay'

# TODO: Support Range for Delta comparisons.

#
class WithinAssay < CompareAssay

  register :within

  #
  # Check assertion.
  #
  def self.pass?(actual, criterion, delta)
    case delta
    when Numeric
      a = actual.to_f
      c = criterion.to_f
      d = delta.to_f

      (c - d) <= a && (c + d) >= a
    else
      a = actual
      c = criterion
      d = delta

      (c - d) <= a && (c + d) >= a
    end
  end

  #
  def pass_message(target)
    actual    = target.inspect
    criterion = criteria[0].inspect
    delta     = criteria[1].inspect

    if actual.size > SIZE_LIMIT or criterion.size > SIZE_LIMIT
      "y - d <= x <= y + d\nx) #{actual}\ny) #{criterion}\nd) #{delta}"
    else
      "#{criterion} - #{delta} <= #{actual} <= #{criterion} + #{delta}"
    end
  end

  #
  #def self.fail_message(actual, criterion, delta)
  #  "! " + pass_message(actual, criterion, delta)
  #end

end

