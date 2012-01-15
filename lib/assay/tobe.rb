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
  class ToBe

    NAMES = {
      :== => :equal,
      :=~ => [:case, :match]
    }

    #
    def new(target)
      @target = target
    end

    #
    # Meta-programming routine for creating all the subjective methods.
    #
    def self.bootstrap
      Assay.constants.each do |const|
        next unless const < Assertion

        name  = (const.operator || cont.assertive_name).to_sym
        names = [NAMES[name] || name].flatten

        name.each do |name|
          define_method("#{name}") do |*args|
            const.assert(@target, *args)
          end

          define_method("not_#{name}") do |*args|
            const.refute(@target, *args)
          end
        end
      end
    end

    #
    # Do it!
    #
    bootstrap

  end

end

