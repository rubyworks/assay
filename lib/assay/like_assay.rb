require_relative 'assertion'

# LikeAssay defines an assertion for broad equality.
#
class LikeAssay < Assertion

  register :like

  #
  # Test assertion for `#like?`.
  #
  def self.pass?(subject, criterion)
    subject.like?(criterion)
  end

end

