require_relative 'execution_assay'

#
class RaiseAssay < ExecutionAssay

  #
  def self.assertive_name
    :raises
  end

  #
  def self.assertion_name!
    :not_raised
  end

  #
  def self.assert(exp, msg=nil, call=nil) #:yeild:
    begin
      yield
      #msg = msg || fail_message(exp)
      test = false
      args = [exp]
    rescue Exception => err
      #msg = msg || fail_message(exp, err)
      test = (exp === err)
      args = [exp, err]
    end
    if !test
      err = new(msg, :backtrace=>(call || caller), :arguments=>args)
      fail err
    end
  end

  #
  def self.assert!(exp, msg=nil, call=nil) #:yield:
    begin
      yield
      test = true
      args = [exp]
    rescue Exception => err
      #msg = msg || fail_message!(exp, err)
      test = (exp === err)
      args = [exp, err]
    end
    if !test
      err = new(msg, :backtrace=>(call || caller), :arguments=>args)
      fail err
    end
  end

  # Check assertion.
  #
  # Note: This is not used by the #assert method.
  def self.pass?(*exp)
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
  def self.fail?(*exp)
    begin
      yield
      true
    rescue Exception => e
      !exp.any?{ |x| x === e }
    end
  end

  # TODO: how to add `but got class` instead.
  def to_s
    return @mesg if @mesg
    return super unless @arguments.size == 1

    exp = @arguments[0].inspect
    #err = @_arguments[1].inspect

    if @_negated
      "Expected #{exp} NOT to be raised"
    else
      "Expected #{exp} to be raised" #, but was #{err} instead."
    end
  end

end
