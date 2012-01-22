## InstanceAssay

The `InstanceAssay` asserts that an object is an instance of a specific class.

    assert InstanceAssay.pass?(1, Fixnum)

    refute InstanceAssay.pass?(1, Numeric)
    refute InstanceAssay.pass?(1, String)

And conversely,

    assert InstanceAssay.fail?(1, String)
    assert InstanceAssay.fail?(1, Numeric)

    refute InstanceAssay.fail?(1, Fixnum)

