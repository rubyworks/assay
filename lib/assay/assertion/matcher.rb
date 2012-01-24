module Assay

  class Assertion

    # Matcher delegate to Assay class.
    #
    class Matcher

      #
      #
      def initialize(assay_class)
        @assay = assay_class
      end

      #
      #
      def pass?(subject)
        @assay.pass?(subject)
      end

      #
      #
      def fail?(subject)
        @assay.fail?(subject)
      end

      #
      #
      def assert!(subject)
        @assay.assert!(subject)
      end

      #
      #
      def refute!(subject)
        @assay.refute!(subject)
      end

      alias_method :==, :pass?
      alias_method :!=, :fail?

      alias_method :=~, :assert!
      alias_method :!~, :refute!

      alias_method :===, :assert!

    end

  end

end
