# Query methods the AE notation relies on. Most are also in Ruby Facets.
# Kernel#identical?, #true? and #false? come with Assay itself.

module Kernel
  # Word form of `#==`. Can take a block instead of a value.
  def eq?(value=NA) #:yield:
    self == (block_given? ? yield : value)
  end

  # Word form of `#===`. Can take a block instead of a value.
  def case?(value=NA) #:yield:
    self === (block_given? ? yield : value)
  end

  # Word form of `#=~`. Can take a block instead of a value. An object
  # without `#=~` matches nothing, as Object#=~ did before Ruby 3.2.
  #
  # String, Symbol and Regexp have their own `#match?`.
  def match?(value=NA)
    value = yield if block_given?
    respond_to?(:=~) ? (self =~ value) : nil
  end

  # Broad equality: identical, `eql?`, `==` or `===`.
  def equate?(x)
    equal?(x) || eql?(x) || self == x || self === x
  end

  # Can a message be sent to the receiver successfully? Only a missing
  # +method+ counts as failure; a NoMethodError raised from inside the
  # method is a bug, and is raised as usual.
  def send?(method, *args, **kw, &block)
    __send__(method, *args, **kw, &block)
    true
  rescue NoMethodError => error
    raise unless error.name == method.to_sym && error.receiver.equal?(self)
    false
  end
end

class Object
  # Allows `equal?` to take a block.
  def equal?(value=NA) #:yield:
    block_given? ? super(yield) : super
  end

  # Allows `eql?` to take a block.
  def eql?(value=NA) #:yield:
    block_given? ? super(yield) : super
  end
end

class Numeric
  # Is the number within +delta+ of another?
  #
  #   0.05.in_delta?(50000.0 / 10**6, 0.00001)
  #
  def in_delta?(orig, delta=0.001)
    delta >= (orig - self).abs
  end

  # Is the number within +epsilon+ of another, relative to the smaller
  # of the two magnitudes?
  def in_epsilon?(orig, epsilon=0.001)
    in_delta?(orig, [orig.abs, self.abs].min * epsilon)
  end
end

class Module
  # Is a given class or module an ancestor of this class or module?
  #
  #   class X ; end
  #   class Y < X ; end
  #
  #   Y.is?(X)  #=> true
  #
  def is?(base)
    Module===base && ancestors.slice(1..-1).include?(base)
  end
end

class Proc
  # Does calling the procedure raise the exception, or a kind of it?
  def raises?(exception=Exception, *args)
    call(*args)
    false
  rescue exception => error
    exception === error
  end

  # Does calling the procedure throw +sym+? Throwing another symbol
  # counts as no; any error is raised as usual.
  def throws?(sym, *args)
    catch(sym) do
      begin
        call(*args)
      rescue UncaughtThrowError
      end
      return false
    end
    return true
  end

  # Does calling the procedure change what the block returns?
  def change?
    pre_result = yield
    call
    post_result = yield
    pre_result != post_result
  end
end

class Symbol
  # Does the block throw this symbol? Throwing another symbol counts
  # as no; any error is raised as usual.
  def thrown?(*args)
    catch(self) do
      begin
        yield(*args)
      rescue UncaughtThrowError
      end
      return false
    end
    return true
  end
end

class Exception
  # Does the block raise this exception, or a kind of it?
  def self.raised? #:yield:
    yield
    false
  rescue self
    true
  end

  # Was the assertion that raised this exception a negated one?
  def negative?
    @negative || false
  end

  # Set whether the exception came from a negated assertion.
  def set_negative(boolean)
    @negative = !!boolean
  end
end
