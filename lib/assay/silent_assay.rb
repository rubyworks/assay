require_relative 'output_assay'

# Assert that there is no output, either from stdout or stderr.
#
#   SilentAssay.pass?{ puts 'foo!' }  #=> false
#
class SilentAssay < OutputAssay

  register :silent

  #
  # Compare +match+ against $stdout and $stderr via `#===` method.
  # 
  # Note that $stdout and $stderr are temporarily reouted to StringIO
  # objects and the results have any trailing newline chomped off.
  #
  def self.pass?(&block)
    require 'stringio'

    begin
      stdout, stderr = $stdout, $stderr
      newout, newerr = StringIO.new, StringIO.new
      $stdout, $stderr = newout, newerr
      yield  
    ensure
      $stdout, $stderr = stdout, stderr
    end

    newout, newerr = newout.string.chomp("\n"), newerr.string.chomp("\n")

    newout.empty? && newerr.empty?
  end

  # TODO: Assertable isn't dealing with no-argument assertions well,
  #       see if this can be improved.

  #
  # Opposite of `SilentAssay.pass?`.
  #
  def self.fail?(&block)
    ! pass?(&block)
  end

  #
  #
  #
  def self.assert_message(*)
    "unexpected output"
  end

  #
  #
  #
  def self.refute_message(*)
    "expected output"
  end

end

