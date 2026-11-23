## OutputAssay

The `OutputAssay` asserts that a output is sent to either `$stdout` or `$stderr`.

Let's do the simple stdout case first.

    assert OutputAssay.pass?('foo'){ puts 'foo' }

    refute OutputAssay.pass?('foo'){ nil }
    refute OutputAssay.pass?('foo'){ puts 'bar' }

And conversely,

    refute OutputAssay.fail?('foo'){ puts 'foo' }

    assert OutputAssay.fail?('foo'){ nil }
    assert OutputAssay.fail?('foo'){ puts 'bar' }

Now the same for `$stderr`.

    assert OutputAssay.pass?('foo'){ $stderr.puts 'foo' }

    refute OutputAssay.pass?('foo'){ nil }
    refute OutputAssay.pass?('foo'){ $stderr.puts 'bar' }

And conversely,

    refute OutputAssay.fail?('foo'){ $stderr.puts 'foo' }

    assert OutputAssay.fail?('foo'){ nil }
    assert OutputAssay.fail?('foo'){ $stderr.puts 'bar' }

The OutputAssay uses `#===` to test the match so we can also 
match against a regular expression.

    assert OutputAssay.pass?(/f/){ puts 'foo' }

    assert OutputAssay.pass?(/f/){ $stderr.puts 'foo' }

