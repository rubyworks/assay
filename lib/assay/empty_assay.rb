require_relative 'include_assay'

# Empty assertion tests an object with `#empty?` method.
#
class EmptyAssay < IncludeAssay

  register :empty

  #
  # Check assertion with `#empty?`.
  #
  def self.pass?(subject)
    subject.empty?
  end

end

