require_relative 'assertion'

#
#
class LikeAssay < Assertion

  register :like

  #
  # Test assertion for `#like?`.
  #
  def self.pass?(subject, criterion)
    subject.like?(criterion)
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

