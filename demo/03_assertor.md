# Assay as Assertor

Assay classes can be converted to assertors, otherwise known as *matchers* in
RSpec circles. The idea behind Assertors is that they can be initialized with
pre-set criteria and then applied to target subjects.

## Standard Target Matching

    assertor = EqualAssay[1]

    assertor.assert!(1)

    expect EqualAssay do
      assertor.assert!(2)
    end

## Partial Arguments

    assertor = LessAssay[1,__]

We can apply the assertor using the `#pass!` method.

    assertor.assert!(2)

Likewise we can assert the negated expression using `#fail!`.

    assertor.refute!(0)

Assay partial a very versile because they allow any argument to become
the target of a assertor.

    assertor = CompareAssay[2,1,__]

    assertor.assert!(1)
    assertor.refute!(0)

## Match Operator

The `#=~` method is an alias for `#assert!`.

    assertor = EqualAssay[1]
    assertor =~ 1

Conversely, `#!~` method is an alias for `#refute!`.

    assertor !~ 2

## Case Operator

The `#===` method is also an alias for `#assert!`.

    assertor === 1

This allows the `case` statement to be used in an intersting way.

    case 10
    when KindAssay[Numeric]
    when EqualAssay[10.0]
    end

## Negated Assertors

Assertors can also be negated so that pass and fail methods swap behaviors.

    assertor = EqualityAssay[1]

    assertor.not =~ 2
    assertor.not !~ 1

For conveience we can also negate the assertor using the `~` unary operator.

    !assertor === 2

## Just Cheking

Assertors can also be used just to test the assertion without actually 
raising the associated exception.

    assertor = EqualityAssay[__,1]

    assertor.pass?(1)
    assertor.fail?(2)

## RSpec Compatability

RSpec compatibality is provided via neccessary method alias, in particular
`#matches?` and `#does_not_match?`.

    assertor = EqualityAssay[__,1]

    assert assertor.matches?(1)
    assert assertor.does_not_match?(2)

Error messages are handle by RSpec by `#failure_message_for_should` and
`#failure_message_for_should_not`.

    assertor.failure_message_for_should(1)
    assertor.failure_message_for_should_not(2)

