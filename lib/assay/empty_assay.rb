require_relative 'include_assay'

# Empty assertion tests an object with `#empty?` method.
#
class EmptyAssay < IncludeAssay

  register :empty

  # Check assertion.
  def self.pass?(target)
    target.empty?
  end

end

