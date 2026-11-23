## StdoutAssay

The `StdoutAssay` asserts that a output is sent to `$stdout`.

    assert StdoutAssay.pass?('foo'){ puts 'foo' }

    refute StdoutAssay.pass?('foo'){ nil }
    refute StdoutAssay.pass?('foo'){ puts 'bar' }

And conversely,

    refute StdoutAssay.fail?('foo'){ puts 'foo' }

    assert StdoutAssay.fail?('foo'){ nil }
    assert StdoutAssay.fail?('foo'){ puts 'bar' }

The StdoutAssay uses `#===` to test the match so we can also 
match against a regular expression.

    assert StdoutAssay.pass?(/f/){ puts 'foo' }

