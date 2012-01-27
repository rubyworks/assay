require_relative 'assertion'

# Assert that a kind of exception class is rescued
# from the execution of a block.
#
class RescueAssay < Assertion

  register :rescued

  #
  # Check assertion.
  #
  def self.pass?(*exceptions)
    exceptions = [RuntimeError] if exceptions.empty?
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
    exceptions = [RuntimeError] if exceptions.empty?
    begin
      yield
      true
    rescue Exception => e
      !exceptions.any? do |x|
        x === e
      end
    end
  end

  # TODO: How to add `but got class` message to error?
  #       May have to override #assert! and #refute! method.

  #
  def self.assert_message(*exceptions)
    exp = exceptions.map{ |e| e.inspect }.join(' or ')
    "raise #{exp}" #, but was #{err} instead."
  end

  #
  def self.refute_message(*exceptions)
    exp = exceptions.map{ |e| e.inspect }.join(' or ')
    "! raise #{exp}" #, but was #{err} instead."
  end

end
