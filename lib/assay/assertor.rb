module Assay

  # Assertor delegates to Assay class. It provides an object-oriented
  # interface to makeing assertions, as opposed to the functional
  # interface of the Assay classes themselves.
  #
  class Assertor

    #
    #
    def initialize(assay_class, *criteria, &block)
      @assay    = assay_class
      @criteria = criteria
      @block    = block
      @not      = false
    end

    #
    #
    def pass?(subject, &block)
      arguments, block = complete_criteria(subject, &block)
      @not ^ @assay.pass?(*arguments, &block)
    end

    #
    #
    def fail?(subject, &block)
      arguments, block = complete_criteria(subject, &block)
      @not ^ @assay.fail?(*arguments, &block)
    end

    #
    #
    def assert!(subject, &block)
      # technically this needs to be controlled by the assay class
      if block.nil? && Proc === subject
        block   = subject
        subject = NA
      end

      arguments, block = complete_criteria(subject, &block)

      if @not
        @assay.refute!(*arguments, &block)
      else
        @assay.assert!(*arguments, &block)
      end
    end

    #
    #
    def refute!(subject, &block)
      # technically this needs to be controlled by the assay class
      if block.nil? && Proc === subject
        block   = subject
        subject = NA
      end

      arguments, block = complete_criteria(subject, &block)

      if @not
        @assay.assert!(*arguments, &block)
      else
        @assay.refute!(*arguments, &block)
      end
    end

    alias_method :==, :pass?
    alias_method :!=, :fail?

    alias_method :=~, :assert!
    alias_method :!~, :refute!

    alias_method :===, :assert!

    #
    # Create a negated form of the matcher.
    #
    # @todo Should this be @! method instead?
    #
    def ~@
      dup.negate!
    end

    #
    # Create a negated form of the matcher.
    #
    # @todo Best name for this method?
    #
    def negated
      dup.negate!
    end

    #
    #
    #
    def assert_message(subject, &block)
      @assay.assert_message(subject, *criteria, &block)
    end

    #
    #
    #
    def refute_message(subject, &block)
      @assay.refute_message(subject, *criteria, &block)
    end

    # The following methods allow Assay objects to work as RSpec matchers.

    # For RSpec matcher compatability.
    alias matches? pass?

    # For RSpec matcher compatability.
    alias does_not_match? fail?

    # For RSpec matcher compatability.
    alias failure_message_for_should assert_message

    # For RSpec matcher compatability.
    alias failure_message_for_should_not refute_message

  protected

    #
    # Toggle the `@not` flag.
    #
    def negate!
      @not = !@not
      self
    end

  private

    #
    #
    #
    def complete_criteria(subject, &block)
      block = block || @block

      return @criteria, block if subject == NA

      if i = @criteria.index(NA)
        args = @criteria[0...i] + [subject] + @criteria[i+1..-1]
      else
        args = [subject] + @criteria
      end

      return args, block
    end

  end

end









=begin

  # Assertion Matcher is used to convert an Assertion class into an 
  # Matcher class.
  #
  # TODO: Better name for this class ?
  #
  class Matcher

    #
    def initialize(assertion, *criteria, &block)
      @assertion = assertion
      @criteria = criteria
      @block     = block
    end

    #
    def assertion
      @assertion
    end

    #
    def pass?(subject)
      if Proc === subject && @block.nil?
        @assertion.pass?(*@criteria, &subject)
      else
        @assertion.pass?(*complete_criteria(subject), &@block)
      end
    end

    #
    def fail?(subject)
      if Proc === subject && @block.nil?
        @assertion.fail?(*@criteria, &subject)
      else
        @assertion.fail?(*complete_criteria(subject), &@block)
      end
    end

    #
    def pass!(subject)
      if Proc === subject && @block.nil?
        @assertion.pass!(*@criteria, &subject)
      else
        @assertion.pass!(*complete_criteria(subject), &@block)
      end
    end

    #
    def fail!(subject)
      if Proc === subject && @block.nil?
        @assertion.fail!(*@criteria, &subject)
      else
        @assertion.fail!(*complete_criteria(subject), &@block)
      end
    end

    alias_method :==, :pass?
    alias_method :!=, :fail?

    alias_method :=~, :pass!
    alias_method :!~, :fail!

    alias_method :===, :pass!

    #
    def pass_message(subject)
      @assertion.pass_message(*complete_criteria(subject))
    end

    #
    def fail_message(subject)
      @assertion.fail_message(*complete_criteria(subject))
    end

    # For RSpec matcher compatability.
    alias matches? pass?

    # For RSpec matcher compatability.
    alias does_not_match? fail?

    # For RSpec matcher compatability.
    alias failure_message_for_should pass_message

    # For RSpec matcher compatability.
    alias failure_message_for_should_not fail_message

    ##
    ## Returns Exception instance.
    ##
    #def exception(subject, msg=nil)
    #  @assertion.new(msg || message, subject, *@criteria, &@block)     
    #  #  :negated   => options[:negated],
    #  #  :backtrace => options[:backtrace] || caller,
    #end

    ##
    #def fail(*args)
    #  super(self, *args)
    #end

    # Create a negated form of the matcher.
    #
    # @todo Should this be @! method instead?
    #
    def ~@
      Negated.new(self)
    end

    # Create a negated form of the matcher.
    #
    # @todo Best name for this method?
    #
    def negated
      Negated.new(self)
    end

  private

    def complete_criteria(subject)
      if i = @criteria.index(__)
        @criteria[0...i] + [subject] + @criteria[i+1..-1]
      else
        [subject] +  @criteria
      end
    end

    # Negated Matcher
    #
    class Negated
      def initialize(matcher)
        @matcher = matcher
      end

      def pass?(*a,&b) ; @matcher.fail?(*a,&b) ; end
      def fail?(*a,&b) ; @matcher.pass?(*a,&b) ; end
      def pass!(*a,&b) ; @matcher.fail!(*a,&b) ; end
      def fail!(*a,&b) ; @matcher.pass!(*a,&b) ; end

      alias_method :==, :pass?
      alias_method :!=, :fail?

      alias_method :=~, :pass!
      alias_method :!~, :fail!

      alias_method :===, :pass!

      def method_missing(s, *a, &b)
        @matcher.send(s, *a, &b)
      end
    end

  end

=end

