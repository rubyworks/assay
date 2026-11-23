# RSpec Notation

## Setup

First we need to require the library.

    require 'assay/rspec'

This loads Assay and adds `#should` and `#should_not` to `BasicObject`.
The matcher methods are in the module `Assay::RSpec::Matchers`, which
is also included into `Assay::Matchers`. To use them, include either
module into the test scope.

    include Assay::Matchers

With that in place, we are ready to use the matchers.
