module Assay

  # This module holds the object "must" methods, which are mixed in to
  # all objects.
  #
  module ObjectiveMust

    #
    # Meta-programming routine for creating all the subjective methods.
    #
    def self.bootstrap
      Assay.constants.each do |const|
        next unless const < Assertion

        name = const.objective_name

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

end

