require_relative 'compare_assay'

#
#
class LikeAssay < CompareAssay

  # Test assertion.
  def self.pass?(actual, criterion)
    criterion.equal?(actual) ||
    criterion.eql?(actual)   ||
    criterion.==(actual)     ||
    criterion.===(actual)
  end

  ##
  #def pass_message(actual, criterion)
  #  actual    = actual.inspect
  #  criterion = criterion.inspect
  #
  #  if actual.size > SIZE_LIMIT or criterion.size > SIZE_LIMIT
  #    "a.like? b\na) #{criterion}\nb) #{actual}"
  #  else
  #    "#{criterion}.like? #{actual}"
  #  end
  #end

  #
  #def self.fail_message(actual, criterion)
  #  "! " + pass_message(actual, criterion)
  #end

end

