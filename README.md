Kata04
======

http://codekata.com/kata/kata04-data-munging/

Evaluation
----------

### Part One ###

This went quite fluently, now that I decided to implement `maybeParse` and `maybeWord`.
The domain logic is really simle (a type and two functions), but I managed to get the order of the fields wrong.
The fix was quite simle, because of the parser: really just switch the order in one place.

I really should have `maybeParse` and `maybeWord` in a tool belt somewhere.
Perhaps they already exist, but I will look into that later.

Time for part two!

### Part Two and Three ###

Well, this was easy.
Implementing `parse` was already done, and the instance `Record Soccer` was peanuts.
Of course, I already split `maybeRead` (the function formerly known as `maybeParse`) and `maybeWord`, and that might have been more foresight than warranted.

This feels like the correct way to implement this, though.
Maybe, tomorrow, I may be able to do this in a single pomodoro!

Refactoring: well, I did a rename, and I may dive into extracting the `s` parameter from both `parse` implementations.
But that seems overkill, at this level.  And parsing may depend on the `s` in different ways.
