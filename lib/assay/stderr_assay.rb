require_relative 'output_assay'

# Assert that there is output $stderr.
#
#   StderrAssay.pass?(/foo/){ $stderr.puts 'foo!' }  #=> true
#
class StderrAssay < OuputAssay

  register :stderr

  #
  # Check assertion via `#===` method.
  #
  def self.pass?(match, &block)
    require 'stringio'

    begin
      stderr  = $stderr
      newerr  = StringIO.new
      $stderr = newerr
      yield  
    ensure
      $stderr = stderr
    end

    match === newerr.string
  end

end

