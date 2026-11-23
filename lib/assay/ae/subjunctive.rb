require_relative 'assertor'

module Assay::AE

  # Subjunctive
  #
  # Mixin for Assertor that provides additional English-eque verbage
  # such as 'be' and 'an'. This makes it easier to create assertor
  # methods of subjunctive terms like 'should'.
  #
  module Subjunctive

    # Like #assert, except if an argument is provided and no block,
    # uses #equate? to compare the argument to the receiver. This
    # allows for statements of the form:
    #
    #   5.should.be Numeric
    #
    def be(*args, &block)
      return self if args.empty? && !block
      block = args.shift if !block && ::Proc === args.first
      if block
        pass = block.arity > 0 ? block.call(@delegate) : block.call  #@delegate.instance_eval(&block)
        msg = args.shift || @message || block.inspect
      else
        match = args.shift
        pass  = match.equate?(@delegate)
        msg   = args.shift || @message || ::Kernel.proc { "#{'! ' if @negated}#{__inspect__(match)} equate? #{__inspect__(@delegate)}" }
      end
      __assert__(pass, msg)
    end

    # Alias of #be.
    #
    #   5.assert.is Numeric
    #
    alias_method :is  , :be
    alias_method :does, :be

    # The indefinite article is like #be, except that it compares a lone argument
    # with #case?, rather than #equate?
    #
    def a(*args, &block)
      return self if args.empty? && !block
      block = args.shift if !block && ::Proc === args.first
      if block
        pass = block.arity > 0 ? block.call(@delegate) : block.call  #@delegate.instance_eval(&block)
        msg = args.shift || @message || block.inspect
      else
        match = args.shift
        pass  = (match === @delegate) # case equality
        msg   = args.shift || @message || ::Kernel.proc { "#{'! ' if @negated}#{__inspect__(match)} === #{__inspect__(@delegate)}" }
      end
      __assert__(pass, msg, ::CaseAssay)
    end

    alias_method :an, :a
  end

end

class Assay::AE::Assertor
  include ::Assay::AE::Subjunctive
end

# Copyright (c) 2008 Thomas Sawyer
