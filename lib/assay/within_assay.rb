require_relative 'compare_assay'

# TODO: Support Range for Delta comparisons.

#
class WithinAssay < CompareAssay

  #
  def self.operator
    :within?
  end

  #
  def self.assertive_name
    :within
  end

  # Check assertion.
  def self.pass?(actual, criterion, delta)
    case delta
    when Numeric
      (criterion.to_f - actual.to_f).abs <= delta.to_f
    else
      criterion - actual <= delta
    end
  end

  #
  def self.pass_message(actual, criterion, delta)
    actual    = actual.inspect
    criterion = criterion.inspect
    delta     = delta.inspect

    if actual.size > SIZE_LIMIT or criterion.size > SIZE_LIMIT
      "b - #{delta} <  a  < b + #{delta}\na) #{actual}\nb) #{criterion}"
    else
      "#{criterion} - #{delta} < #{actual} < #{criterion} + #{delta}"
    end
  end

  #
  def self.fail_message(actual, criterion, delta)
    "! " + pass_message(actual, criterion, delta)
  end

end

