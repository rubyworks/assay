require_relative 'handlers/extensions'

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
      Assay.constants.each do |const|
        next unless const < Assertion

        name = const.objective_name.to_sym
        name = BANG_NAME[name] || name

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

  end

end

