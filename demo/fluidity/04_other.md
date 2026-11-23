## Other Stuff

What if there is an assertion made for which no Assay class exists?
If the target object has a query method defined by the same name,
that is, one ending in a `?` mark, then that mehtod will be used 
to test the assertion.

    c = Class.new do
      def initialize(truth)
        @truth = truth
      end
      def yes?
        @truth
      end
      def no?
        !@truth
      end
    end

    x = c.new(true)

    x.should.be.yes

    x.should_not.be.no


And such an assertion fails when the query says otherwise.

    RaiseAssay.assert!(Assertion) do
      x.should.be.no
    end

    RaiseAssay.assert!(Assertion) do
      x.should_not.be.yes
    end
