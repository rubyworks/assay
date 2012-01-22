require_relative 'assertion'

# Assert the existance of a file with `File.file?` call.
#
class PathAssay < Assertion

  register :path

  #
  # Check assertion using `File.exist?` method.
  #
  def self.pass?(path)
    File.exist?(path)
  end

end

