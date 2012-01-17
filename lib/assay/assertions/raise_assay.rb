require_relative 'execution_assay'

#
class RaiseAssay < ExecutionAssay

  #
  def self.operator
    :raise?
  end

  #
  def self.assertive_name
    :raise
  end

  #
  #
  #
  def pass!(*exp) #:yeild:
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

    message   = options[:message]   || message(*arguments)
    backtrace = options[:backtrace] || caller

    if !test
      fail self, message, backtrace
    end
  end

  #
  #
  #
  def fail!(*exp) #:yield:
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

    message   = options[:message]   || message(*arguments)
    backtrace = options[:backtrace] || caller

    if !test
      fail self, message, backtrace
    end
  end

  # Check assertion.
  #
  # Note: This is not used by the #assert method.
  def pass?(*exp)
    begin
      yield
      false
    rescue Exception => e
      exp.any?{ |x| x === e }
    end
  end

  # Check negated assertion.
  #
  # Note: This is not used by the #assert! method.
  def fail?(*exp)
    begin
      yield
      true
    rescue Exception => e
      !exp.any?{ |x| x === e }
    end
  end

  # TODO: how to add `but got class` instead.
  def message(*arguments)
    return @mesg if @mesg
    #return super unless arguments.size == 1

    exp = arguments.map{ |e| e.inspect }.join(' or ')

    if @_negated
      "Expected #{exp} NOT to be raised"
    else
      "Expected #{exp} to be raised" #, but was #{err} instead."
    end
  end

end
