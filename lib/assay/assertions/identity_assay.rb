require_relative 'compare_assay'

# TODO: Should equal? and identical be different?

# Check that two objects are the very same.
#
class IdentityAssay < CompareAssay

  #
  def self.operator
    :equal?
  end

  #
  def self.assertive_name
    :identical
  end

  #
  # Check assertion using `object_id == object_id`.
  #
  def self.pass?(act, exp)
    exp.object_id == act.object_id
  end

  #
  def self.pass_message(actual, criterion)
    actual    = actual.inspect
    criterion = criterion.inspect

    if actual.size > SIZE_LIMIT or criterion.size > SIZE_LIMIT
      "a.object_id == b.object.id\na) #{criterion}\nb) #{actual}"
    else
      "#{criterion}.object_id == #{actual}.object.id"
    end
  end

  #
  def self.fail_message(actual, criterion)
    actual    = actual.inspect
    criterion = criterion.inspect

    if actual.size > SIZE_LIMIT or criterion.size > SIZE_LIMIT
      "a.object_id != b.object.id\na) #{criterion}\nb) #{actual}"
    else
      "#{criterion}.object_id != #{actual}.object.id"
    end
  end

end

