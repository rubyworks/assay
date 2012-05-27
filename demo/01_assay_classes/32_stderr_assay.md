## StderrAssay

The `StderrAssay` asserts that a output is sent to `$stderr`.

    assert StderrAssay.pass?('foo'){ $stderr.puts 'foo' }

    refute StderrAssay.pass?('foo'){ nil }
    refute StderrAssay.pass?('foo'){ $stderr.puts 'bar' }

And conversely,

    refute StderrAssay.fail?('foo'){ $stderr.puts 'foo' }

    assert StderrAssay.fail?('foo'){ nil }
    assert StderrAssay.fail?('foo'){ $stderr.puts 'bar' }

The StderrAssay uses `#===` to test the match so we can also 
match against a regular expression.

    assert StderrAssay.pass?(/f/){ $stderr.puts 'foo' }

