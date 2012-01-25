require_relative 'equality_assay'

# Check that two objects are one and the same object.
#
# NOTE: Ruby defines #equal? to mean #identical? but I believe
# this to be a misnomer, at the very least. So we use the term
# `identical` instead.
#
class IdentityAssay < EqualityAssay

  register :identical

  #
  # Check assertion using `object_id == object_id`.
  #
  def self.pass?(subject, criterion)
    subject.identical?(criterion)  #subject.object_id == criterion.object_id
  end

#  #
#  #
#  #
#  def assert_message(subject)
#    a = subject.inspect
#    b = criteria.first.inspect
#
#    if a.size > SIZE_LIMIT or b.size > SIZE_LIMIT
#      "a.identical?object_id == b.object.id\na) #{criterion}\nb) #{actual}"
#    else
#      "#{criterion}.object_id == #{actual}.object.id"
#    end
#  end
#
#  #
#  #
#  #
#  def refute_message(subject)
#    actual    = subject.inspect
#    criterion = criteria.first.inspect
#
#    if actual.size > SIZE_LIMIT or criterion.size > SIZE_LIMIT
#      "a.object_id != b.object.id\na) #{criterion}\nb) #{actual}"
#    else
#      "#{criterion}.object_id != #{actual}.object.id"
#    end
#  end

end

