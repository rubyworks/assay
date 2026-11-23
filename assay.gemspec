require_relative 'lib/assay/version'

Gem::Specification.new do |s|
  s.name        = 'assay'
  s.version     = Assay::VERSION
  s.summary     = 'Class-based assertions, and the notations built on them'
  s.description = 'Assay defines assertions the way Ruby defines exceptions: each kind of ' \
                  'assertion is a class, which knows how to test, how to explain a failure, and ' \
                  'is the exception raised. On top of the classes it provides a choice of ' \
                  'notations: Minitest and Test::Unit style assertion methods, RSpec style ' \
                  'matchers, and a fluent notation of its own.'

  s.authors     = ['Thomas Sawyer']
  s.email       = ['transfire@gmail.com']

  s.homepage    = 'https://github.com/rubyworks/assay'
  s.license     = 'BSD-2-Clause'

  s.metadata    = {
    'source_code_uri' => 'https://github.com/rubyworks/assay',
    'changelog_uri'   => 'https://github.com/rubyworks/assay/blob/master/HISTORY.md',
    'bug_tracker_uri' => 'https://github.com/rubyworks/assay/issues'
  }

  s.required_ruby_version = '>= 2.7'

  s.files       = Dir['lib/**/*.rb', 'demo/**/*', 'LICENSE.txt', 'README.md', 'HISTORY.md', '.yardopts']
  s.require_paths = ['lib']

  s.add_dependency 'brass', '>= 1.2'
  s.add_dependency 'ansi', '>= 1.5'

  s.add_development_dependency 'rake', '>= 13'
  s.add_development_dependency 'qed', '>= 2.9'
  s.add_development_dependency 'rubytest', '>= 0.11.1'
  s.add_development_dependency 'lemon', '>= 0.9'
  s.add_development_dependency 'minitest', '>= 5.0'
  s.add_development_dependency 'test-unit', '>= 3.0'
end
