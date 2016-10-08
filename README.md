Kata04
======

http://codekata.com/kata/kata04-data-munging/

Evaluation
----------

At this moment, I realize that I cannot parse this file on `words` any longer.  I need to parse exact lengths...

Wow. This was waaaay more load than I estimated.
I took it upon myself to parse *all* fields now, instead of just the ones I need for the answer.
And to start off using a seperate module for the `Record` class.
So, this may have been a case of "YAGNI" and "premature separation of concerns" or something like that.

Well, I learned interesting stuff nonetheless.
Parsing ranges is not really hard, but the data entry needed is not nice.
I guess A `ranges :: [Int] -> String -> [String]` function would be nice here.

And I learned that the linker complains about missing functions if module containing them is not exposed.
It's a gnarly error to read, but when one module in the executable uses another in the library, it needs to be exposed.
As I'm "used to" .NET assembly linking and projects and references, this caused a tiny bit of confusion, but it's cleaner, I guess :)
Just need to be alert on what the error means.
