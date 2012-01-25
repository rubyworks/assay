require_relative 'output_assay'

# Assert that there is output, either from stdout or stderr.
#
#   StdoutAssay.pass?(/foo/){ puts 'foo!' }  #=> true
#
class StdoutAssay < OutputAssay

  register :output

  #
  # Check assertion via `#===` method.
  #
  def self.pass?(match, &block)
    require 'stringio'

    begin
      stdout  = $stdout
      newout  = StringIO.new
      $stdout = newout
      yield
    ensure
      $stdout = stdout
    end

    match === newout.string.chomp("\n")
  end

end

