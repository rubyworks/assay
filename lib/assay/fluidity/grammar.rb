require_relative '../../assay'

module Assay; end
module Assay::Fluidity

  module Grammar

    # The grammar classes are built on BasicObject, so that a method every
    # object has, such as `kind_of?`, `nil?` or `eql?`, makes an assertion
    # about the target rather than being answered by the grammar object.
    class Base < ::BasicObject

      # BasicObject has a few public methods of its own. Making them private
      # sends them through #method_missing like any other.
      private :!, :equal?, :instance_eval, :instance_exec

      def initialize(target, negate=false)
        @target = target
        @negate = negate
      end

      # Have to override the ususal `#==` method to support this.
      def ==(other)
        if @negate
          ::EqualAssay.refute!(@target, other, :backtrace=>::Kernel.caller)
        else
          ::EqualAssay.assert!(@target, other, :backtrace=>::Kernel.caller)
        end
      end

      # Likewise for `#!=`.
      def !=(other)
        if @negate
          ::UnequalAssay.refute!(@target, other, :backtrace=>::Kernel.caller)
        else
          ::UnequalAssay.assert!(@target, other, :backtrace=>::Kernel.caller)
        end
      end

      def method_missing(s, *a, **kw, &b)
        if assay = (::Assertion.by_name(s) || ::Assertion.by_operator(s))
          a << kw unless kw.empty?
          if @negate
            assay.refute!(@target, *a, {:backtrace=>::Kernel.caller}, &b)
          else
            assay.assert!(@target, *a, {:backtrace=>::Kernel.caller}, &b)
          end
        else
          q = (s.to_s.end_with?('?') ? s : (s.to_s+'?'))
          if @target.respond_to?(q)
            truth = @target.__send__(q, *a, **kw, &b)
            args  = (a.map{ |x| x.inspect } + kw.map{ |k,v| "#{k}: #{v.inspect}" }).join(', ')
            call  = "#{@target.inspect}.#{q}" + (args.empty? ? '' : "(#{args})")
            if @negate
              ::Kernel.assert(!truth, ::Assertion, "! #{call}", ::Kernel.caller)
            else
              ::Kernel.assert(truth, ::Assertion, call, ::Kernel.caller)
            end
          else
            super
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
