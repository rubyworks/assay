module Assay::RSpec

  # Delegate to Have Assays.
  #
  class Have

    attr :expected

    attr :collection_name

    attr :relation

    #
    # Initialize new Have delegator.
    #
    def initialize(expected, relation=:exactly)
      @expected = case expected
                  when :no then 0
                  when String then expected.to_i
                  else expected
                  end
      @relation        = relation
      @collection_name = nil
    end

    #
    # @param [#size,#length,#count] collection_or_owner
    #
    def collection(collection_or_owner)
      if collection_or_owner.respond_to?(@collection_name)
        collection_or_owner.__send__(@collection_name, *@args, &@block)
      elsif query_method(collection_or_owner)
        collection_or_owner
      else
        collection_or_owner.__send__(@collection_name, *@args, &@block)
      end
    end

    #
    #
    #
    def query_method(collection)
      [:size, :length, :count].detect {|m| collection.respond_to?(m)}
    end

    #
    #
    #
    def method_missing(method, *args, &block)
      @collection_name = method
      @args  = args
      @block = block

      case @relation
      when :at_least
        Assay::RSpec::HaveAtLeastAssay.assertor(self)
      when :at_most
        Assay::RSpec::HaveAtMostAssay.assertor(self)
      else
        Assay::RSpec::HaveExactlyAssay.assertor(self)
      end
    end

    #
    #
    module Helpers

      #
      #
      #
      def collection_set(collection_or_owner, have)
        collection   = have.collection(collection_or_owner)
        query_method = query_method(collection)

        raise not_a_collection(have) unless query_method

        actual = collection.__send__(query_method)

        return collection, query_method, actual
      end

      #
      # Return the actual size of the collection.
      #
      def collection_actual(collection_or_owner, have)
        collection_set(collection_or_owner, have).last
      end

      #
      # Which size method to use: `size`, `length` or `count`.
      #
      def query_method(collection)
        [:size, :length, :count].detect {|m| collection.respond_to?(m)}
      end

      #
      # Message to use when collection doesn't respond to `size`, `length` or `count`.
      #
      def not_a_collection(have)
        "expected #{have.collection_name} to be a collection but it does not respond to #length, #size or #count"
      end

      #
      # TODO: use when verbose error message mode
      #
      def self.assert_description(collection_or_owner, have)
        collection, method, actual = collection_set(collection_or_owner, have)
        "expected #{have.relation} #{have.expected} #{have.collection_name}, got #{actual}"
      end

      #
      #
      #
      def self.refute_descrptipon(collection_or_owner, have)
        collection, method, actual = collection_set(collection_or_owner, have)
        "expected not to have #{have.relation} #{have.expected} #{have.collection_name}, got #{actual}"
      end

    end

  end

  #
  #
  class HaveExactlyAssay < EqualAssay

    extend Have::Helpers

    register :have

    #
    #
    #
    def self.pass?(collection_or_owner, have)
      actual = collection_actual(collection_or_owner, have)
      super(actual, have.expected)
    end

    #
    # Error message for have equal assertion.
    #
    def self.assert_message(collection_or_owner, have)
      actual = collection_actual(collection_or_owner, have)
      super(actual, have.expected)
    end

  end

  #
  #
  class HaveAtLeastAssay < MoreEqualAssay

    extend Have::Helpers

    register :have_at_least

    #
    #
    #
    def self.pass?(collection_or_owner, have)
      actual = collection_actual(collection_or_owner, have)
      super(actual, have.expected)
    end

    #
    #
    #
    def self.assert_message(collection_or_owner, have)
      actual = collection_actual(collection_or_owner, have)
      super(actual, have.expected)
    end

  end
  
  #
  #
  class HaveAtMostAssay < LessEqualAssay

    extend Have::Helpers

    register :have_at_most

    #
    #
    #
    def self.pass?(collection_or_owner, have)
      actual = collection_actual(collection_or_owner, have)
      super(actual, have.expected)
    end

    #
    #
    #
    def self.assert_message(collection_or_owner, have)
      actual = collection_actual(collection_or_owner, have)
      super(actual, have.expected)
    end

  end

end
