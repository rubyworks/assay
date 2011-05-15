--- !ruby/object:Gem::Specification 
name: assay
version: !ruby/object:Gem::Version 
  hash: 19
  prerelease: false
  segments: 
  - 0
  - 3
  - 0
  version: 0.3.0
platform: ruby
authors: 
- Thomas Sawyer
autorequire: 
bindir: bin
cert_chain: []

date: 2011-05-07 00:00:00 -04:00
default_executable: 
dependencies: 
- !ruby/object:Gem::Dependency 
  name: ansi
  prerelease: false
  requirement: &id001 !ruby/object:Gem::Requirement 
    none: false
    requirements: 
    - - ">="
      - !ruby/object:Gem::Version 
        hash: 21
        segments: 
        - 1
        - 2
        - 5
        version: 1.2.5
  type: :runtime
  version_requirements: *id001
- !ruby/object:Gem::Dependency 
  name: redline
  prerelease: false
  requirement: &id002 !ruby/object:Gem::Requirement 
    none: false
    requirements: 
    - - ">="
      - !ruby/object:Gem::Version 
        hash: 3
        segments: 
        - 0
        version: "0"
  type: :development
  version_requirements: *id002
- !ruby/object:Gem::Dependency 
  name: qed
  prerelease: false
  requirement: &id003 !ruby/object:Gem::Requirement 
    none: false
    requirements: 
    - - ">="
      - !ruby/object:Gem::Version 
        hash: 3
        segments: 
        - 0
        version: "0"
  type: :development
  version_requirements: *id003
description: The Assay project defines Assertions in the same way that Ruby defines Exceptions. An asserition then simply becomes an extension to an Exception class.
email: transfire@gmail.com
executables: []

extensions: []

extra_rdoc_files: 
- README.rdoc
files: 
- .ruby
- qed/01_failure_classes.rdoc
- qed/02_assertives.rdoc
- qed/03_matchers.rdoc
- qed/04_lookup.rdoc
- lib/assay/adapters/minitest.rb
- lib/assay/adapters/testunit.rb
- lib/assay/assertion.rb
- lib/assay/assertions/compare_failure.rb
- lib/assay/assertions/delta_failure.rb
- lib/assay/assertions/empty_failure.rb
- lib/assay/assertions/equality_failure.rb
- lib/assay/assertions/execution_failure.rb
- lib/assay/assertions/false_failure.rb
- lib/assay/assertions/identity_failure.rb
- lib/assay/assertions/instance_failure.rb
- lib/assay/assertions/kind_failure.rb
- lib/assay/assertions/match_failure.rb
- lib/assay/assertions/nil_failure.rb
- lib/assay/assertions/raise_failure.rb
- lib/assay/assertions/response_failure.rb
- lib/assay/assertions/same_failure.rb
- lib/assay/assertions/throw_failure.rb
- lib/assay/assertions/true_failure.rb
- lib/assay/matcher.rb
- lib/assay.rb
- lib/assay.yml
- HISTORY.rdoc
- APACHE2.txt
- README.rdoc
- NOTICE.rdoc
has_rdoc: true
homepage: http://rubydoc.info/gems/assay
licenses: 
- Apache 2.0
post_install_message: 
rdoc_options: 
- --title
- Assay API
- --main
- README.rdoc
require_paths: 
- lib
required_ruby_version: !ruby/object:Gem::Requirement 
  none: false
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      hash: 3
      segments: 
      - 0
      version: "0"
required_rubygems_version: !ruby/object:Gem::Requirement 
  none: false
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      hash: 3
      segments: 
      - 0
      version: "0"
requirements: []

rubyforge_project: assay
rubygems_version: 1.3.7
signing_key: 
specification_version: 3
summary: Class-based Assertions Framework
test_files: []

