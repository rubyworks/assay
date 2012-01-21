require_relative 'compare_assay'

# TODO: Should equal? and identical be different?

# Check that two objects are the very same.
#
class IdentityAssay < CompareAssay

  # TODO: I reall think this should be identical?
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
  #
  #
  def pass_message(target)
    actual    = target.inspect
    criterion = criteria.first.inspect

    if actual.size > SIZE_LIMIT or criterion.size > SIZE_LIMIT
      "a.object_id == b.object.id\na) #{criterion}\nb) #{actual}"
    else
      "#{criterion}.object_id == #{actual}.object.id"
    end
  end

  #
  #
  #
  def fail_message(target)
    actual    = target.inspect
    criterion = criteria.first.inspect

    if actual.size > SIZE_LIMIT or criterion.size > SIZE_LIMIT
      "a.object_id != b.object.id\na) #{criterion}\nb) #{actual}"
    else
      "#{criterion}.object_id != #{actual}.object.id"
    end
  end

end

