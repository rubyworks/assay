## FileAssay

The `FileAssay` asserts that a file-system path exists and it is a file.

    file = __FILE__
    dir  = File.dirname(file)
    dne  = __FILE__ + '~'

    assert FileAssay.pass?(file)

    refute FileAssay.pass?(dir)
    refute FileAssay.pass?(dne)

And conversely,

    assert FileAssay.fail?(dir)
    assert FileAssay.fail?(dne)

    refute FileAssay.fail?(file)

