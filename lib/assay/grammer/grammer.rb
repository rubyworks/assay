module Assay

  module Grammer

    class Base

      def initialize(target, negate=false)
        @target = target
        @negate = negate
      end

    private

      def call(s, *a, &b)
        if assay = Assertion.by_operator(s)
          if @negate
            assay.fail!(@target, *a, &b)
          else
            assay.pass!(@target, *a, &b)
          end
        else
          super(s, *a, &b)
        end
      end

    end

    #
    class Be < Base

      def method_missing(s, *a, &b)
        call(s, *a, &b)
      end

      #
      def a
        self
      end

      #
      def an
        self
      end

    end

    #
    class Is < Be

      def not
        Is.new(@target, !@negate)
      end

    end

    #
    class Must < Base

      def be
        Be.new(@target, @negate)
      end

      def not
        Must.new(@target, !@negate)
      end

    end

    #
    class Should < Base

      def be
        Be.new(@target, @negate)
      end

      def not
        Should.new(@target, !@negate)
      end

    end

  end

end
