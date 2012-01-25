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
    # The assay class to which this assertor delegates.
    #
    attr :assay

    #
    # The criteria for applying the assertor.
    #
    attr :criteria

    #
    # Block criterion.
    #
    attr :block

    #    
    # Is the assertor negated?
    #
    def not?
      @not
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
    def !@
      dup.negate!
    end

    #
    # Create a negated form of the matcher.
    #
    # @todo Best name for this method?
    #
    def not
      dup.negate!
    end

    #
    # Assertion message. This is only used by RSpec compatibility methods.
    #
    def assert_message(subject, &block)
      arguments, block = complete_criteria(subject, &block)
      @assay.assert_message(*arguments, &block)
    end

    #
    # Refutation message. This is only used by RSpec compatibility methods.
    #
    def refute_message(subject, &block)
      arguments, block = complete_criteria(subject, &block)
      @assay.refute_message(*arguments, &block)
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

    ##
    ## Returns Assay instance.
    ##
    #def exception(subject, msg=nil)
    #  @assay.new(msg || message, subject, *criteria, &block)
    #  #  :negated   => options[:negated],
    #  #  :backtrace => options[:backtrace] || caller,
    #end

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

