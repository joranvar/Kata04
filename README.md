Kata04
======

http://codekata.com/kata/kata04-data-munging/

Evaluation
----------

Here is where I start Part Three, DRY.

Here is where I start going berserk on the DRY.

Well.  Maybe not really *berserk*.
I am not done berserking yet, though :P
Adding a `label` to a `Record` does not seem bad.
Adding `find` may be a bit problematic, because it is `findMinBy`, and that would call for other variants as well.
Even worse: that would really be copying all functions from `List`, I guess, which can not be good in this case.

I do want to do something with the `maybeRead =<< maybeWord` stuff, and still don't like that `words` is called so often (for each `maybeWord`).
I wonder if implementing a `Parse` applicative thingy would enable me to combine all calls for one input.

Otherwise, the DRY does not feel too wrong, yet. Answering question three is still the same as last time (for now).
Questions one and two are irrelevant now, I think.  I design with "map . parse . words" in mind, and that sticks.
