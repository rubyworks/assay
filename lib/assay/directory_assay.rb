require_relative 'path_assay'

# Assert the existance of a directory with `File.directory?` call.
#
class DirectoryAssay < PathAssay

  #
  # Check assertion using `File.file?` method.
  #
  def self.pass?(path)
    File.directory?(path)
  end

end

# I would prefer this name. 
#FolderAssay = DirectoryAssay

