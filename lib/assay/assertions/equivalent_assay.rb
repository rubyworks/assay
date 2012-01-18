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
  def self.pass?(actual, criterion)
    criterion.eql?(actual)
  end

  #
  def self.pass_message(actual, criterion)
    actual    = actual.inspect
    criterion = criterion.inspect

    if actual.size > SIZE_LIMIT or criterion.size > SIZE_LIMIT
      "a.eql? b\na) #{criterion}\nb) #{actual}"
    else
      "#{criterion}.eql? #{actual}"
    end
  end

  #
  def self.fail_message(actual, criterion)
    "! " + pass_message(actual, criterion)
  end

end

