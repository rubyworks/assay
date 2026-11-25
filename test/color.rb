# Color can be turned on from outside Assay: the ANSI gem sets `$ansi`
# when it loads, as it does under Rubytest. A failed comparison of long
# values must then still raise its assertion, with the differences
# colored. Each check runs in a process of its own, so that nothing else
# has loaded the diff library first.

require 'rbconfig'

long_a = 'a' * 20
long_b = 'b' * 20

checks = {
  'EqualAssay' => %[
    require 'assay'
    $ansi = true
    EqualAssay.assert!(#{long_a.inspect}, #{long_b.inspect})
  ],
  'UnequalAssay' => %[
    require 'assay'
    $ansi = true
    UnequalAssay.assert!(#{long_a.inspect}, #{long_a.inspect})
  ],
  'AE notation' => %[
    require 'assay/ae'
    $ansi = true
    #{long_a.inspect}.assert == #{long_b.inspect}
  ]
}

failed = false

checks.each do |name, script|
  script = "begin; #{script}; rescue Exception => e; " \
           "puts [e.class.name, e.assertion?.inspect, e.message].join('|'); end"
  output = IO.popen([RbConfig.ruby, '-Ilib', '-e', script], err: [:child, :out], &:read)
  klass, assertion, message = output.split('|', 3)
  expected = (name == 'UnequalAssay' ? 'UnequalAssay' : 'EqualAssay')
  if klass == expected && assertion == 'true' && message.to_s.include?("\e[")
    puts "ok      #{name}"
  else
    failed = true
    puts "not ok  #{name}: expected a colored #{expected}, got\n#{output}"
  end
end

exit 1 if failed
