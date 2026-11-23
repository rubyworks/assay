## RSpec Expect

### expect

Expect is RSpecs new and approved assertion notation. It works
very much like `#should` but it isn't an Object extension, which
is considered a "*better practice*".

    expect(10).to eq(10)

### operators

It can also delegate operators, so the above example can also be
written.

    expect(10).to == 10

    assert_raises EqualAssay do
      expect(10).to == 20
    end


Any other operator is sent to the object, and has to come back true.

    expect(10).to > 5

    assert_raises LessEqualAssay do
      expect(10).to <= 5
    end

### blocks

Given a block instead of a value, `expect` passes the block to the
matcher, which is how raising and throwing are tested.

    expect{ raise ArgumentError }.to raise_error(ArgumentError)

    expect{ :fine }.to_not raise_error(ArgumentError)

    assert_raises RaiseAssay do
      expect{ :fine }.to raise_error(ArgumentError)
    end
