require_relative 'rescue_assay'

#
class RaiseAssay < RescueAssay

  register :raised

  #
  # Check assertion.
  #
  def self.pass?(*exceptions)
    exceptions = [Exception] if exceptions.empty?
    begin
      yield
      false
    rescue Exception => e
      exceptions.any? do |x|
        Module === x ? x === e : x == e.class
      end
    end
  end

  #
  # Check negated assertion.
  #
  def self.fail?(*exceptions)
    exceptions = [Exception] if exceptions.empty?
    begin
      yield
      true
    rescue Exception => e
      !exceptions.any? do |x|
        Module === x ? x === e : x == e.class
      end
    end
  end

  # TODO: How to add `but got class` to message?
  #       May have to override `#assert!` and `#refute!`.

  #
  #
  #
  def self.assert_message(*exceptions)
    exp = exceptions.map{ |e| e.inspect }.join(' or ')
    "raise #{exp}" #, but was #{err} instead."
  end

  #
  #
  #
  def self.refute_message(*exceptions)
    exp = exceptions.map{ |e| e.inspect }.join(' or ')
    "! raise #{exp}" #, but was #{err} instead."
  end

=begin
  #
  #
  #
  def self.assert!(*exp) #:yeild:
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
  def self.refute!(*exp) #:yield:
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

end
