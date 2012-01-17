require_relative 'compare_assay'

# Comparison assertion for #kind_of?
#
#   KindAssay.pass?(1, Integer)  #=> true
#   KindAssay.fail?(1, String)   #=> true
#
class KindAssay < CompareAssay

  #
  def self.operator
    :kind_of?
  end

  #
  def self.assertive_name
    :kind_of
  end

  # Check assertion.
  def pass?(obj, cls)
    obj.kind_of?(cls)
  end

  #
  def message(*arguments)
    return @mesg if @mesg
    return super unless arguments.size == 2

    obj = arguments[0].inspect
    cls = arguments[1].inspect

    if @_negated
      "Expected #{obj} to be kind of #{cls}"
    else
      "Expected #{obj} to be kind of #{cls}"
    end
  end
end

