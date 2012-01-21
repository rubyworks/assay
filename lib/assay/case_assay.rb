require_relative 'equality_assay'

# Equality assertion using `#===`, the case equality method.
#
class CaseAssay < EqualityAssay

  #
  def self.operator
    :===
  end

  #
  def self.assertive_name
    :case
  end

  #
  # Check assertion via `#===` method.
  #
  def self.pass?(target, criterion)
    criterion === target
  end

end

