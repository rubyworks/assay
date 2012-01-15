require 'assertions/failures/instance'

module Assertable

  # Passes if object .instance_of? klass
  #
  #   assert_instance_of(String, 'foo')
  #
  def self.instance_of(cls, obj, opts={})
    opts[:backtrace] ||= caller
    InstanceFailure.assert(cls, act, opts)
  end

  # Passes if object .instance_of? klass
  #
  #   assert_instance_of(String, 'foo')
  #
  def self.not_instance_of(cls, obj, opts={})
    opts[:backtrace] ||= caller
    InstanceFailure.assert!(cls, act, opts)
  end

end
