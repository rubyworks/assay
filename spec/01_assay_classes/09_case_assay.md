## CaseAssay

The `CaseAssay` class defines an assertion for case equality using the `#===`
method.

    assert CaseAssay.pass?(1, 1)
    assert CaseAssay.pass?(1, 1.0)
    assert CaseAssay.pass?(/a/, 'a')

    refute CaseAssay.pass?(1, 2)
    refute CaseAssay.pass?(1, 'foo')

And conversely,

    assert CaseAssay.fail?(1, 2)
    assert CaseAssay.fail?(1, 'foo')

    refute CaseAssay.fail?(1, 1)
    refute CaseAssay.fail?(1, 1.0)
    refute CaseAssay.fail?(/a/, 'a')

