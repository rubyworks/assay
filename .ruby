---
source:
- meta
authors:
- name: Thomas Sawyer
  email: transfire@gmail.com
copyrights:
- holder: Thomas Sawyer
  year: '2007'
  license: BSD-2-Clause
replacements: []
alternatives: []
requirements:
- name: ansi
  version: ! '>=1.2.5'
- name: detroit
  groups:
  - build
  development: true
- name: qed
  groups:
  - test
  development: true
dependencies: []
conflicts: []
repositories:
- uri: git@github.com:rubyworks/assay.git
  scm: git
  name: upstream
resources:
  home: http://rubydoc.info/gems/assay
  docs: http://rubydoc.info/gems/assay
  code: http://github.com/rubyworks/assay
  mail: http://groups.google.com/groups/rubyworks-mailinglist
extra: {}
load_path:
- lib
revision: 0
created: '2009-08-21'
summary: Class-based Assertions Framework
title: Assay
name: assay
description: ! 'The Assay project defines Assertions in the same way that Ruby defines
  Exceptions.

  An asserition then simply becomes an extension to an Exception class.'
organization: Rubyworks
version: ''
date: '2012-01-14'
