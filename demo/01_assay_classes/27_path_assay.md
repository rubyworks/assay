## PathAssay

The `PathAssay` asserts that a file-system path exists.

    file = __FILE__
    dir  = File.dirname(file)
    dne  = __FILE__ + '~'

    assert PathAssay.pass?(file)
    assert PathAssay.pass?(dir)

    refute PathAssay.pass?(dne)

And conversely,

    assert PathAssay.fail?(dne)

    refute PathAssay.fail?(file)
    refute PathAssay.fail?(dir)

