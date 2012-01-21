# What About Those Errors?

One curmedgeon I have with Assay in it's current form is that
Ruby's built-in errors are never used as assertion errors, even though
the `#set_assertion` standard which Assay supports makes it perfectly possible,
and indeed, some assertions seem very appropriate to it, such 
as raising a `TypeError` for a failed `#kind_of?` or `#instance_of?`
assertion.

In practice, I don't think it really matters that a `#kind_of?` assertion
raises a `KindAssay` whereas `#instance_of` raises an `InstanceAssay`. I can't
think of a single scenario in which that would be necessary to distiguish.
And if it were, we could create `class InstanceError < TypeError` and use that 
instead.

So I am inclined to reimplement Assay to raise actual error classes instead
of the Assay classes themselves. This is a fundamental change, since the 
Assay classes were orginally conceived of as Exception subclasses.

Because this change would in effect make the instance level of the Assay classes
void of functionality, it would make sense, in do doing, to reconstruct Assays
as simple objects, instead of classes, defined something like:

  Asssay.new(:kind_of, :error=>TypeError) do |target, criterion|
    criterion.kind_of?(target)
  end

In most cases such a defintion would be all that is required. If some feature
needs customization then singleton methods can be used to override methods in
these limited cases, e.g.

  Asssay.new(:kind_of, :error=>TypeError) do |target, criterion|
    criterion.kind_of?(target)
  end

  def Assay[:kind_of].message(target, criterion)
    "Some non-standrard message."
  end

But hold on, maybe the best solution is still to define Assays as Exception
subclasses, but piggyback them on the current error hierarchy. In other words,
assertion methods could be added to the current error classes where appropriate
and new error classes created as needed.

  class TypeError
    def self.pass?(target, criterion)
      return false unless Exception === criterion
      return false unless target    === criterion  
      criterion == target
    end
  end

  class KindTypeError < TypeError
    def self.pass?(target, criterion)
      return false unless Exception === criterion
      criterion.kind_of?(target)
    end
  end

  class InstanceTypeError < TypeError
    def self.pass?(target, criterion)
      return false unless Exception === criterion
      criterion.instance_of?(target)
    end
  end

Well, that's doable, but I think it's making a claim about error classes that doesn't
neccessarily jive, namely that an error is defined by a paticular test. When actually
an error might be raised for any number of related reasons. It does seem like a good
idea to nail down errors to what their intended usage, but it is probably too restrictive,
and it would be impossible to cover all conceivable possibilites, let alone easily define
them. Consider the IOError as an example.

There is one other alternative left. Currently Matcher is a separate class. The Assay
classes could be a subclasses of Matcher. We might even forgo defining the assertion
methods at the class level then. [UPDATE] I played with this approach and it's simply
over kill. The above object approach is much beterr.

Okay, so we are left with the current implementation or the above Assay object idea.
Which will it be?

