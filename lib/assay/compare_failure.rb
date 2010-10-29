require 'assay/failure'

module Assay

  class CompareFailure < Failure

    def self.assertion_name
      :like
    end

    def self.fail_message(exp, act)
      "Expected #{act.inspect} to be like #{exp.inspect}"
    end

    def self.fail_message!(exp, act)
      "Expected #{act.inspect} NOT to be like #{exp.inspect}"
    end

    def self.check(exp, act)
      exp.equals?(act) ||
      exp.eq?(act)     ||
      exp.==(act)      ||
      exp.===(act)
    end

  end


  module Assertable


  end


  module Matchers
    #
    #
    #   object1.should be_like(object2)
    #
    def be_like(act)
      CompareFailure.to_matcher(act)
    end

    #
    #
    #   object1.should be_like(object2)
    #
    def is_like(act)
      CompareFailure.to_matcher(act)
    end
  end

end
