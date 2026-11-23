require_relative '../../assay'

module Assay; end
module Assay::Fluidity

  module Grammar

    class Base

      def initialize(target, negate=false)
        @target = target
        @negate = negate
      end

      # Have to override the ususal `#==` method to support this.
      def ==(other)
        if @negate
          ::EqualAssay.refute!(@target, other, :backtrace=>caller)
        else
          ::EqualAssay.assert!(@target, other, :backtrace=>caller)
        end
      end

    #private

      def method_missing(s, *a, &b)
        if assay = (::Assertion.by_name(s) || ::Assertion.by_operator(s))
          if @negate
            assay.refute!(@target, *a, {:backtrace=>caller}, &b)
          else
            assay.assert!(@target, *a, {:backtrace=>caller}, &b)
          end
        else
          q = (s.to_s.end_with?('?') ? s : (s.to_s+'?'))
          if @target.respond_to?(q)
            truth = @target.send(q, *a, &b)
            if @negate
              ::Kernel.assert(!truth, ::Assertion, "! #{@target.inspect}.#{q}", caller)
            else
              ::Kernel.assert(truth, ::Assertion, "#{@target.inspect}.#{q}", caller)
            end
          else
            super(s, *a, &b)
          end
        end
      end

    end

    #
    class Assert < Base

      #def method_missing(s, *a, &b)
      #  call(s, *a, &b)
      #end

      def not
        Assert.new(@target, !@negate)
      end

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
    class Will < Base

      def be
        Be.new(@target, @negate)
      end

      def not
        Will.new(@target, !@negate)
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
