require_relative 'compare_assay'

# Comparison assertion for the #eql? method.
#
# Note, this can be a bit confusing in contrast to TestUnit and MiniTest,
# where "same" means "identical". There doesn't seem to be any assertions
# for `#eql?` in either of those frameworks.
#
class SameAssay < CompareAssay

  #
  def self.operator
    :eql?
  end

  #
  def self.assertive_name
    :eql
  end

  #
  # Check assertion via `#eql?` method.
  #
  def pass?(act, criterion)
    criterion.eql?(act)
  end

  #
  def message(*arguments)
    return @mesg if @mesg
    return super unless arguments.size == 2
  
    exp = arguments[0].inspect
    act = arguments[1].inspect
  
    if @_negated
      "Expected #{act} to NOT be equivalent to #{exp}"
    else
      "Expected #{act} to be equivalent to #{exp}"
    end
  end

end

