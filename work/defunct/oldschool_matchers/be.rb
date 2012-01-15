module Assay

  # This module holds the subject matcher methods, which can be mixin
  # to one's testing scope (e.g. World).
  #
  module Matchers

    #
    # Meta-programming routine for creating all the subjective methods.
    #
    def self.bootstrap
      Assay.constants.each do |const|
        next unless const < Assertion

        name = const.subjective_name

        define_method("be_#{name}") do |*args|
          const.to_matcher(*args)
        end
      end
    end

    #
    # Do it!
    #
    bootstrap

  end

end

