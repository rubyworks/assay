require_relative '../matchers'

module Assay

  # This module provides matchers for RSpec-compatiblity.
  #
  # The set is not fully compataible, but provides most traditional Rspec
  # matchers, less some extraneous verbosity (use of `a` and `an`) and
  # some of the more complex and less common matchers.
  #
  # Compatability will improve with time.
  #
  module RspecMatchers

    RSPEC_NAMES = {
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

        name = const.subjective_name.to_sym

        name = RSPEC_NAMES[name] || name

        define_method("be_#{name}") do |*args|
          const.to_matcher(*args)
        end
      end
    end

    #
    # Do it!
    #
    bootstrap

    # TODO: Improve compatability...

  end

  module Matchers
    include RSpecMatchers
  end

end

