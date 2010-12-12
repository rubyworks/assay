--- !ruby/object:Gem::Specification 
name: assay
version: !ruby/object:Gem::Version 
  hash: 29
  prerelease: false
  segments: 
  - 0
  - 0
  - 1
  version: 0.0.1
platform: ruby
authors: 
- Thomas Sawyer
autorequire: 
bindir: bin
cert_chain: []

date: 2010-12-12 00:00:00 -05:00
default_executable: 
dependencies: 
- !ruby/object:Gem::Dependency 
  name: syckle
  prerelease: false
  requirement: &id001 !ruby/object:Gem::Requirement 
    none: false
    requirements: 
    - - ">="
      - !ruby/object:Gem::Version 
        hash: 3
        segments: 
        - 0
        version: "0"
  type: :development
  version_requirements: *id001
- !ruby/object:Gem::Dependency 
  name: qed
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
description: The Assay project defines Assertions in the same way that Ruby defines Exceptions. An asserition then simply becomes an extension to an Exception class.
email: ""
executables: []

extensions: []

extra_rdoc_files: 
- README.rdoc
files: 
- qed/assertable.rdoc
- qed/failures.rdoc
- qed/matchers.rdoc
- lib/assay/compare_failure.rb
- lib/assay/delta_failure.rb
- lib/assay/empty_failure.rb
- lib/assay/equality_failure.rb
- lib/assay/execution_failure.rb
- lib/assay/failure.rb
- lib/assay/false_failure.rb
- lib/assay/identity_failure.rb
- lib/assay/instance_failure.rb
- lib/assay/kind_failure.rb
- lib/assay/match_failure.rb
- lib/assay/nil_failure.rb
- lib/assay/raise_failure.rb
- lib/assay/response_failure.rb
- lib/assay/return_failure.rb
- lib/assay/same_failure.rb
- lib/assay/throw_failure.rb
- lib/assay/true_failure.rb
- lib/assay.rb
- HISTORY.rdoc
- LICENSE.txt
- README.rdoc
- Syckfile
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

