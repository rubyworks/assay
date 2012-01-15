require 'asserere/failures'

# = Assertable
#
# Singleton methods defined against Assertable
# are transformated into assertions corresponding
# to active nomenclatures and then defined as instance
# methods of Assertable.
#
# Example
#
#   require 'ae/nomenclature/assert'
#   require 'ae/nomenclature/should'
#
#   def Assertable.should_be_like_mike(name)
#     raise CompareFailure.new("Not a Mike!", caller) unless /mike/i =~ name
#   end
#
#   include Assertable
#
#   assert_like_jimmy("Jim Bo")
#   should_be_like_jimmy("Jim Bo")
#
module Assertable

  ObjectSpace.each_object(Class) do |cls|
    if cls < Failure
      define_method(cls.assertable_method) do |*args, &blk|
        opts = Hash === args.last ? args.pop : {}
        opts[:backtrace] ||= caller
        cls.check(*args, opts, &blk)
      end
    end
  end

end

