require_relative 'execution_assay'

#
class RaiseKindAssay < ExecutionAssay

  register :raise_kind

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
        x === e
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
        x === e
      end
    end
  end

  # TODO: how to add `but got class` message to error ?

  #
  def pass_message(subject)
    exp = criteria.map{ |e| e.inspect }.join(' or ')

    "raise #{exp}" #, but was #{err} instead."
  end

  #
  def fail_message(subject)
    exp = criteria.map{ |e| e.inspect }.join(' or ')

    "! raise #{exp}" #, but was #{err} instead."
  end

end
