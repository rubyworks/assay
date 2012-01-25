require_relative 'assertion'

# Assert that there is output, either from stdout or stderr.
#
#   OutputAssay.pass?(/foo/){ puts 'foo!' }  #=> true
#
class OutputAssay < Assertion

  register :output

  #
  # Check assertion via `#===` method.
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

    match === newout.string || match === newerr.string
  end

end

