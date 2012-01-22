# Criterion, the Receiver

From a strictly formal stand-point, it makes sense that the criterion
of an assertion would dictate its defintion. After all, the criterion
is the yardstick by which the assertion is to be measured. For example,
to assert that `1 is equal to 1.0`, clearly `1` is our test subject
and `1.0` the criterion by which the asseratation of equality is judged.
Since methods are non-cummunative, either the subject or the criterion
must be the receiver of the `==` call. Logically then, it should be the
one dictating the test, the criterion. Hence the actual underlying test
code would work out to be `if 1.0 == 1`. Makes sense, right?

Unfortunately in practice it does not work out be so simple. Test equality
is a nice and simple case. It is cummunative in the real world (of math).
Other operations are not. Take for example less-than (`<`). In this case, it
very much matters which object is the receiver. If we say, `1 is less than 2`,
then `1` may well be the subject and `2` the criterion. But to make the criterion
the receiver of the operation would require us to code, `2 > 1`. Which isn't
acceptable becuase now we are using the more-than (`>`) operation instead of
less-than.

Until now, I had been using the criterion as the receiver of the underlying
method call where feasiable, but more often than not it has not been feasible.
So on further reflection, I have decided to give up on this idea, despite and
formal correctness. There simply aren't enough working cases to warrant such
a common expection to the rule. Better to have every assertion work in 
harmonious fashion across the board.

It may not be the formally ideal solution, but it is at least an workable
approach so long as you know how it works. In particular, the important
correlary to this decision: THE TEST SUBJECT ITSELF DEFINES THE MEANS BY
WHICH ASSERTIONS ARE MEASURED AGAINST IT.

If only real life worked that way! ;)

