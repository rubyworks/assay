require_relative '../assay'
require_relative 'containers/extensions'

module Assay

  # This module provides assertion mettods as object extensions in the
  # form of bang methods.
  #
  # Examples
  #
  #   "string".instance_of!(String)
  #
  #   "string".equal!("string")
  #
  #   "string".not_equal!("another")
  #
  module Extensions

    BANG_NAMES = {
      :kind     => :kind_of,
      :instance => :instance_of
    }

    #
    # Meta-programming routine for creating all the subjective methods.
    #
    def self.bootstrap
      Assertion.subclasses.each do |const|
        name = const.assertive_name.to_sym
        name = BANG_NAMES[name] || name

        define_method("#{name}!") do |*args|
          const.assert(self, *args)
        end

        define_method("not_#{name}!") do |*args|
          const.refute(self, *args)
        end
      end
    end

    #
    # Do it!
    #
    bootstrap

    #
    def throw!(sym)
      ThrowAssay.assert(sym, &self)
    end

    #
    def not_throw!(sym)
      ThrowAssay.refute(sym, &self)
    end

  end

end

