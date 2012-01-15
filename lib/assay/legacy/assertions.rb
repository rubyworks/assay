module Assay

  # This module holds the assertive methods, which can be mixed into
  # one's testing scope (e.g. World).
  #
  module AssertiveMethods

    #
    # Meta-programming routine for creating all the subjective methods.
    #
    def self.bootstrap
      Assay.constants.each do |const|
        next unless const < Assertion

        name = const.assertive_name

        define_method("assert_#{name}") do |*args|
          const.assert(*args)
        end

        define_method("refute_#{name}") do |*args|
          const.refute(*args)
        end

        alias_method "assert_not_#{name}", "refute_#{name}"
      end
    end

    #
    # Do it!
    #
    bootstrap

  end

end

