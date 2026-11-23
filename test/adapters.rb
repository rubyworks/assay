# Runs a small suite under Minitest and under Test::Unit with Assay's
# adapter loaded, and checks that a failed assay is counted as a failure
# and not as an error. Each runs in a process of its own, because the two
# frameworks don't share one.

require 'rbconfig'

checks = {
  'minitest_example.rb' => /5 runs, \d+ assertions, 2 failures, 1 errors, 1 skips/,
  'testunit_example.rb' => /4 tests, \d+ assertions, 2 failures, 1 errors/
}

failed = false

checks.each do |file, expected|
  path   = File.join(__dir__, 'adapter', file)
  output = IO.popen([RbConfig.ruby, '-Ilib', path], err: [:child, :out], &:read)
  if output =~ expected
    puts "ok      #{file}"
  else
    failed = true
    puts "not ok  #{file}: expected #{expected.inspect} in\n#{output}"
  end
end

exit 1 if failed
