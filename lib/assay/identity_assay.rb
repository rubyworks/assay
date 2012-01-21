require_relative 'assertion'

# TODO: Note that Ruby defines #equal? to mean #identical? but I believe
# this to be a misnomer, at the very least. So we use the term #identical
# instead.

# Check that two objects are one and the same object.
#
class IdentityAssay < Assertion

  #
  def self.operator
    :identical?
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

#  #
#  #
#  #
#  def fail_message(target)
#    actual    = target.inspect
#    criterion = criteria.first.inspect
#
#    if actual.size > SIZE_LIMIT or criterion.size > SIZE_LIMIT
#      "a.object_id != b.object.id\na) #{criterion}\nb) #{actual}"
#    else
#      "#{criterion}.object_id != #{actual}.object.id"
#    end
#  end

end

