require_relative 'path_assay'

# Assert the existance of a file with `File.file?` call.
#
class FileAssay < PathAssay

  register :file

  #
  # Check assertion using `File.file?` method.
  #
  def self.pass?(path)
    File.file?(path)
  end

end

