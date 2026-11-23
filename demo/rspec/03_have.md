### Have

The `#have` matchers make it easy to set expectations about the size
of a collection. In general the term `items` is used if the target
object is a collection.

    a = [1, 2, 3]

    a.should have(3).items
    a.should_not have(2).items
    a.should_not have(4).items

    a.should have_exactly(3).items
    a.should_not have_exactly(2).items
    a.should_not have_exactly(4).items

    a.should have_at_least(2).items
    a.should have_at_most(4).items

But a method that returns a collection can be used instead.

    class ::String
      def words
        split(' ')
      end
    end

    s = "a sentence with some words"

    s.should have(5).words
    s.should_not have(4).words
    s.should_not have(6).words

    s.should have_exactly(5).words
    s.should_not have_exactly(4).words
    s.should_not have_exactly(6).words

    s.should have_at_least(4).words
    s.should have_at_most(6).words

Besides `#have` there is also `#have_at_least` and `#have_at_most`.

    a = [1, 2, 3]

    a.should have_at_least(2).items
    a.should have_at_most(4).items

    a.should have_at_least(3).items
    a.should have_at_most(3).items


