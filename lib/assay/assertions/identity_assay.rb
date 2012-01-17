require_relative 'compare_assay'

# TODO: Should equal? and identical be different?

# Check that two objects are the very same.
#
class IdentityAssay < CompareAssay

  #
  def self.operator
    :equal?
  end

  #
  def self.assertive_name
    :identical
  end

  #def self.fail_message(exp, act)
  #  "Expected #{act.inspect} to be identical to #{exp.inspect}"
  #end

  #def self.fail_message!(exp, act)
  #  "Expected #{act.inspect} not to be identical to #{exp.inspect}"
  #end

  # Check assertion.
  def pass?(act, exp)
    exp.object_id == act.object_id
  end

  #
  def message(*arguments)
    return @mesg if @mesg
    return super unless arguments.size == 2

    iexp = arguments[0].inspect
    iact = arguments[1].inspect

    if @_negated
      "Expected #{iact} not to be identical to #{iexp}"
    else
      "Expected #{iact} to be identical to #{iexp}"
    end
  end

end

