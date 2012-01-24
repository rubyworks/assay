## DirectoryAssay

The `DirectoryAssay` asserts that a file-system path exists
and it is a directory.

    file = __FILE__
    dir  = File.dirname(file)
    dne  = __FILE__ + '~'

    assert DirectoryAssay.pass?(dir)

    refute DirectoryAssay.pass?(file)
    refute DirectoryAssay.pass?(dne)

And conversely,

    assert DirectoryAssay.fail?(file)
    assert DirectoryAssay.fail?(dne)

    refute DirectoryAssay.fail?(dir)

