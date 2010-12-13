--- 
name: assay
title: Assay
resources: 
  code: http://github.com/rubyworks/assay
  docs: http://rubydoc.info/gems/assay
  home: http://rubydoc.info/gems/assay
requires: 
- group: 
  - build
  name: syckle
  version: 0+
- group: 
  - test
  name: qed
  version: 0+
pom_verison: 1.0.0
manifest: 
- .ruby
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
- Profile
- LICENSE.txt
- README.rdoc
suite: rubyworks
version: 0.0.1
licenses: 
- Apache 2.0
copyright: Copyright (c) 2007 Thomas Sawyer
description: The Assay project defines Assertions in the same way that Ruby defines Exceptions. An asserition then simply becomes an extension to an Exception class.
summary: Class-based Assertions Framework
authors: 
- Thomas Sawyer
created: 2009-08-21
