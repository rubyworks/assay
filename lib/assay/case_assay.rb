require_relative 'equality_assay'

# Equality assertion using `#===`, the case equality method.
#
class CaseAssay < EqualityAssay

  register :===, :case

  #
  # Check assertion via `#===` method.
  #
  def self.pass?(subject, criterion)
    subject === criterion
  end

end

