module Assay

  # This module holds the objective "is" methods, which are mixed in to
  # all objects.
  #
  module Expectations

    #
    # Meta-programming routine for creating all the subjective methods.
    #
    def self.bootstrap
      Assay.constants.each do |const|
        next unless const < Assertion

        name = const.objective_name

        define_method("is_#{name}") do |*args|
          const.assert(self, *args)
        end

        define_method("is_not_#{name}") do |*args|
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

