require_relative 'assertion'

# Assert that there is output, either from stdout or stderr.
#
#   OutputAssay.pass?(/foo/){ puts 'foo!' }  #=> true
#
class OutputAssay < Assertion

  register :output

  #
  # Compare +match+ against $stdout and $stderr via `#===` method.
  # 
  # Note that $stdout and $stderr are temporarily reouted to StringIO
  # objects and the results have any trailing newline chomped off.
  #
  def self.pass?(match, &block)
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

    match === newout || match === newerr
  end

end

