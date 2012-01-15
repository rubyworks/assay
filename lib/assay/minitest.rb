require_relative '../extensions'

module Assay

  # This module provides extensions for MiniTest compatiblity.
  #
  # The set is not fully compataible, but provides most of MiniTest
  # extensions.
  #
  # Compatability will improve with time.
  #
  module MiniTestExtensions

    MINITEST_NAMES = {
      :equal    => :equal_to,
      :instance => :instance_of,
      :kind     => :kind_of,
      :within   => :close,
    }

    #
    # Meta-programming routine for creating all the subjective methods.
    #
    def self.bootstrap
      Assay.constants.each do |const|
        next unless const < Assertion

        name = const.assertive_name.to_sym

        name = RSPEC_NAMES[name] || name

        define_method("must_be_#{name}") do |*args|
          const.assert(self, *args)
        end

        define_method("wont_be_#{name}") do |*args|
          const.refute(self, *args)
        end
      end
    end

    #
    # Do it!
    #
    bootstrap

  end

  module Extensions
    include MiniTestExtensions
  end

end

