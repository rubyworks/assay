require 'assay'

module Assay

  module Grammer

    class Base

      def initialize(target, negate=false)
        @target = target
        @negate = negate
      end

      # Have to override the ususal `#==` method to support this.
      def ==(other)
        if @negate
          EqualityAssay.fail!(@target, other)
        else
          EqualityAssay.pass!(@target, other)
        end
      end

    private

      def method_missing(s, *a, &b)
        if assay = (Assertion.by_name(s) || Assertion.by_operator(s))
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
    class Assert < Base

      #def method_missing(s, *a, &b)
      #  call(s, *a, &b)
      #end

    end

    #
    class Be < Base

      #def method_missing(s, *a, &b)
      #  call(s, *a, &b)
      #end

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

      #def method_missing(s, *a, &b)
      #  call(s, *a, &b)
      #end

      def be
        Be.new(@target, @negate)
      end

      def not
        Must.new(@target, !@negate)
      end

    end

    #
    class Should < Base

      #def method_missing(s, *a, &b)
      #  call(s, *a, &b)
      #end

      def be
        Be.new(@target, @negate)
      end

      def not
        Should.new(@target, !@negate)
      end

    end

  end

end
