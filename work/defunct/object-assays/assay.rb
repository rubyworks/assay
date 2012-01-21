module Assay

  $ASSERTION_COUNTS = Hash.new{ |h,k| h[k] = 0 }

  def self.[](name)
    index[name.to_sym]
  end

  def self.index
    @index ||= {}
  end

  #
  #
  def self.new(name, error=StandardError, options={}, &condition)
    name = name.to_sym
    assay = Definition.new(name, error, options, &condition)
    index[name] = assay
  end

  #
  #
  class Definition

    def initialize(name, error=StandardError, options={}, &test)
      @name  = name
      @error = error || StandardError
      @test  = test
    end

    def name
      @name
    end

    def error
      @error
    end

    # TODO: Better name?
    def test
      @test
    end

    #
    def pass?(*args, &blk)
      @test.call(*args, &blk)
    end

    def assert!(*args, &blk)
      if pass?(*args, &blk)
        increment_counts(:pass)
      else
        increment_counts(:fail)
        raise @error, message(*args, &blk)
      end
    end

    # TODO: Better name?
    def message(*args, &blk)
      "#{name} " + args.inspect
    end

    # TODO: Better name?
    def increment_counts(which)
      $ASSERTION_COUNTS[which] += 1
      $ASSERTION_COUNTS[:total] += 1
    end

  end

end
