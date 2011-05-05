--- 
spec_version: 1.0.0
replaces: []

loadpath: 
- lib
name: assay
repositories: {}

conflicts: []

engine_check: []

title: Assay
resources: 
  code: http://github.com/rubyworks/assay
  docs: http://rubydoc.info/gems/assay
  home: http://rubydoc.info/gems/assay
maintainers: []

requires: 
- group: []

  name: ansi
  version: ">=1.2.5"
- group: 
  - build
  name: redline
  version: 0+
- group: 
  - test
  name: qed
  version: 0+
suite: rubyworks
manifest: MANIFEST.txt
version: 0.2.0
licenses: 
- Apache 2.0
copyright: Copyright (c) 2007 Thomas Sawyer
authors: 
- Thomas Sawyer
description: The Assay project defines Assertions in the same way that Ruby defines Exceptions. An asserition then simply becomes an extension to an Exception class.
summary: Class-based Assertions Framework
created: 2009-08-21
