require_relative 'execution_assay'

#
class RaiseAssay < ExecutionAssay

  register :raised

=begin
  #
  #
  #
  def self.pass!(*exp) #:yeild:
    options = (Hash === exp.last ? exp.pop : {})

    exp = exp.first

    begin
      yield
      test      = false
      arguments = [exp]
    rescue Exception => err
      test      = (exp === err)
      arguments = [exp, err]
    end

    message   = options[:message]   || pass_message(*arguments)
    backtrace = options[:backtrace] || caller

    if !test
      fail self, message, backtrace
    end
  end

  #
  #
  #
  def self.fail!(*exp) #:yield:
    options = (Hash === exp.last ? exp.pop : {})

    #exp = exp.first

    begin
      yield
      test      = true
      arguments = exp
    rescue Exception => err
      test      = !exp.any?{ |e| e === err }
      arguments = exp #+ [err]
    end

    message   = options[:message]   || fail_message(*arguments)
    backtrace = options[:backtrace] || caller

    if !test
      fail self, message, backtrace
    end
  end
=end

  # Note: This is not used by the #assert method. (or is it?)

  # Check assertion.
  #
  def self.pass?(*exceptions)
    exceptions = [Exception] if exceptions.empty?
    begin
      yield
      false
    rescue Exception => e
      exceptions.any?{ |x| x === e }
    end
  end

  # Note: This is not used by the #assert! method.

  # Check negated assertion.
  #
  def self.fail?(*exceptions)
    exceptions = [Exception] if exceptions.empty?
    begin
      yield
      true
    rescue Exception => e
      !exceptions.any?{ |x| x === e }
    end
  end

  #
  def pass_message(subject)
    exp = criteria.map{ |e| e.inspect }.join(' or ')

    "raise #{exp}" #, but was #{err} instead."
  end

  # TODO: how to add `but got class` instead.
  def fail_message(subject)
    exp = criteria.map{ |e| e.inspect }.join(' or ')

    "! raise #{exp}" #, but was #{err} instead."
  end

end
