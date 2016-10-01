Kata04
======

Evaluation
----------

This time I got a bit further.  Parsing the file works better with just `map . words`.

I used an interesting way to "test" the correctness of parsing the file: run the test, see what the outcome really was, then change the expectation.  That does not feel right.

I could not really think of a property.

I also do not know, really, how useful the function definitions are, right now.  Parsing seems okay, but the very, very specialist function of "finding the smallest spread" seems really inelegant.  It feels as if I should be able to pass the comparison function, or whatever.  Maybe I should give more meaningful functions on `Weather`, instead of trying to define something on the list.  Make the types convey meaning, instead of `List -> Int`.

I do like that I used `Data.Function.on`, and `Data.List.minimumBy`.  I should remember how that works.

I want to make more use of the automated test suite, as well. "error: no parse" is not good feedback.
