require 'assertions/failures/raises'

module Assertable

  # Passes if the block raises a given exceptions.
  #
  #   assert_raises RuntimeError do
  #     raise 'Boom!!!'
  #   end
  #
  def self.raises(exp, msg=nil, call=nil, &blk) #:yeild:
    RaiseFailure.assert(exp, msg=nil, call=nil, &blk)
  end

  # Passes if the block *does not* raise a given exceptions.
  #
  #   assert_not_raised IOError do
  #     raise 'Boom!!!'
  #   end
  #
  def self.not_raised(exp, msg=nil, call=nil, &blk) #:yeild:
    RaiseFailure.assert!(exp, msg, call, &blk)
  end

end
