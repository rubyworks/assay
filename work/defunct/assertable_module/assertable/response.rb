require 'assertions/failures/response'

module Assertable
  # Passes if +object+ respond_to? +methods+.
  #
  #   assert_respond_to 'bugbear', :slice
  #
  def assert_respond_to(reciever, method, opts={})
    opts[:backtrace] ||= caller
    ResponseFailure.assert(reciever, method, opts)
  end

  # Passes if +object+ does not respond_to? +methods+.
  #
  #   assert_not_respond_to 'bugbear', :slice
  #
  def assert_not_respond_to(reciever, method, opts={})
    opts[:backtrace] ||= caller
    ResponseFailure.assert!(reciever, method, opts)
  end
end
