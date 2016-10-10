Kata04
======

http://codekata.com/kata/kata04-data-munging/

Evaluation
----------

I tried a different answer type this time (because parsing a file without valid records could fail).

I also tried to re-design parse to use `words` only once.  Looks good, seems that the tests are quicker now.

I did not (yet) really refactor everything.  Maybe in my second pomodoro!

Cheers,
Bart

### Second pomodoro ###

Well, moving `parse`, `parseFile` and `maybeRead` felt good.
Especially, since only `parse` needed to be a class method, and `parseFile` sits there as util function.
Moving `minimumOn` could have been to a different module, but it is a nice util function (which probably exists).

Then, I moved `labelOfMinimumInFile`.  Well.  Using `label` as a method is quite nice, because it seems useful.
But `labelOfMinimumInFile` is a really simple composition, of stuff that is accidentally similar, feels like.
I would not extract that stuff, unless I were writing a more complete library of functions on record files.

Finally, the step of moving `parse` to use `parseWords` seemed good.
I can really imagine other methods, `parseSep` and `parseFixed`, that give a separator or some ranges to split the fields on, making usage more flexible again.
If I spent some more time, the `maybeRead` could be extracted as well, giving some heterogeneous list to `parseWords`
(that might be some kind of consed tuples for "flexible length").

I saw some solution in Python on the kata page (see above), that generically parsed files into a list of maps from field name to value.
That does not sit well with me, as it is not as type safe.  But it is darned generic.
If I have time in my second pomodoro tomorrow, I may look into that.

I had fun again.

Oh, question three: "as much as possible" is not always good.
I would only factor out code that would be reasonably generic, otherwise the code would still not be reusable for other cases.

Maintainability may have suffered now, because a copy of the "hidden" Record.labelOfMinimumInFile implementation would be needed to change a requirement in the number of records returned or if other data (besides label) was needed.
Or if input was from different files, or different formats (for the same types of records).

Readability: suffered a bit, because how to name that hideously comical function so that it reads correctly with the `p` parameter?  I have no idea :p
