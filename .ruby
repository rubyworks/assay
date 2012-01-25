---
source:
- meta
authors:
- name: Thomas Sawyer
  email: transfire@gmail.com
copyrights:
- holder: Thomas Sawyer
  year: '2009'
  license: BSD-2-Clause
replacements: []
alternatives: []
requirements:
- name: ansi
- name: brass
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
version: 0.4.0
name: assay
description: ! 'The Assay project defines Assertions in the same way that Ruby defines
  Exceptions.

  An asserition then simply becomes an extension to an Exception class.'
organization: Rubyworks
date: '2012-01-25'
