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
  home: http://rubyworks.github.com/assay
  docs: http://rubydoc.info/gems/assay/frames
  code: http://github.com/rubyworks/assay
  bugs: http://github.com/rubyworks/assay/issues
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
description: ! 'Assay defines assertions in the same way that Ruby defines exceptions.

  Each type of asserition, called an assay, is then a child of the base

  Assertion class, which itself is a subclass of the Exception class.'
organization: Rubyworks
date: '2012-01-25'
