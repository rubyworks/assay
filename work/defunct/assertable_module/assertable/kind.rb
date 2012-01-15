require 'assertions/failures/kind'

module Assertable

  # Passes if object .kind_of? klass
  #
  #   assert_kind_of(Object, 'foo')
  #
  def assert_kind_of(cls, obj, opts={})
    opts[:backtrace] ||= caller
    KindFailure.assert(exp, act, opts)
  end

  # Passes if object .kind_of? klass
  #
  #   assert_not_kind_of(Object, 'foo')
  #
  def assert_not_kind_of(cls, obj, opts={})
    opts[:backtrace] ||= caller
    KindFailure.assert!(exp, act, opts)
  end

end
