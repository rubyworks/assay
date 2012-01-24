require_relative 'assertor'

module Assay

  module Assertable

    $ASSERTION_COUNTS ||= Hash.new{ |h,k| h[k] = 0 } #{:total=>0,:pass=>0,:fail=>0}

    #
    # When displaying errors, use this as a rule of thumb
    # for determining when the inspected object will be too
    # big for a single line message.
    #
    SIZE_LIMIT = 13

    #
    # If the assertion coresponds to a regular method, particular a symbolic
    # operator (hence the name of this method) then it should be specified via
    # this interface. Otherwise, it should be given a fitting "make believe"
    # method name and specified here. If not overridden it will be assumed
    # to be the same as the `assertion_name` appended by `?`.
    #
    def operator
      @operator ||= (name.split('::').last.chomp('Assay').downcase + '?').to_sym
    end

    #
    # The assertive name is used for the construction of assertive nomenclatures
    # such as `assert_equal`.
    # 
    def assertive_name
      @assertion_name ||= (
        if operator.to_s.end_with?('?')
          operator.to_s.chomp('?').to_sym
        else
          name.split('::').last.chomp('Assay').downcase.to_sym
        end
      )
    end

    #
    # Create an assertor for the assay class, given +criteria+.
    #
    def assertor(*criteria, &block)
      Assertor.new(self, *criteria, &block)
    end

    #
    # Alias for `#assertor`.
    #
    def [](*criteria, &block)
      assertor(*criteria, &block)
    end

    #
    # Check the assertion, return `true` if passing, `false` otherwise.
    #
    def pass?(subject, *criteria, &block)
      subject 
    end

    #
    # Check the assertion, return `true` if failing, `false` otherwise.
    #
    def fail?(subject, *criteria, &block)
      ! pass?(subject, *criteria, &block)
    end

    #
    # Test the assertion, raising the exception if failing.
    #
    def assert!(*arguments, &block)
      options = (Hash === arguments.last ? arguments.pop : {})

      backtrace = options[:backtrace] || caller
      message   = options[:message]   || assert_message(*arguments, &block)

      if pass?(*arguments, &block)
        increment(:pass)
      else
        increment(:fail)
        fail self, message, backtrace
      end
    end

    #
    # Test the refutation of the assertion.
    #
    # Test the inverse assertion, raising the exception if not failing.
    #
    def refute!(*arguments, &block)
      options = (Hash === arguments.last ? arguments.pop : {})

      backtrace = options[:backtrace] || caller
      message   = options[:message]   || refute_message(*arguments, &block)

      if fail?(*arguments, &block)
        increment(:pass)
      else
        increment(:fail)
        fail self, message, backtrace
      end
    end

    #
    #
    #
    def get_message(subject, fail=false)
      @not ^ fail ? refute_message(subject) : assert_message(subject)
    end

    #
    #
    #
    def assert_message(*arguments, &block)
      standard_message(*arguments, &block)
    end

    #
    #
    #
    def refute_message(*arguments, &block)
      "! " + assert_message(*arguments, &block)
    end

  private

    #
    # Increment global `$ASSERTION_COUNTS` variable.
    #
    def increment(which)
      $ASSERTION_COUNTS[:total] += 1
      $ASSERTION_COUNTS[which.to_sym] += 1
    end

    #
    # Construct a standard error message.
    #
    def standard_message(*arguments, &block)
      args_inspect = arguments.map{ |o| o.inspect }

      op = self.operator.to_s
      op = (/\w/ =~ op) ? ".#{op} " : " #{op} "

      if args_inspect.any?{ |o| o.size > SIZE_LIMIT }
        vars = ['b']
        t = args_inspect.size - 2
        t.times{ vars << vars.last.succ }

        msg = ''   
        msg << "a#{op} " + vars.join(',') + "\n"
        msg << args_inspect.join("\n")
        msg
      else
        args_inspect.first + "#{op}" + args_inspect[1..-1].join(', ') + ""
      end
    end

  end

end
