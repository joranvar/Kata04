Kata04
======

http://codekata.com/kata/kata04-data-munging/

Evaluation
----------

Defining the data went well enough, and the `spread` function is
really okay, I guess.

Reading seems to be a bit too much dependent on what I know of the
format of the file.  I should either make it really generic, or just
bite my tongue and drop the lines which I know I am not interested in.

Time went by quite fast, probably because I could not decide how to
quickly return a correct implementation.  Reading the file in the test
would make it run while programming.  But that would mean to put the
"file specific" IO code (and the "File format" to `[Weather]` code)
either in the Lib or in the Test.  Both places don't feel right.

Next time, I will try to move all the parsing code into the Lib again,
just not the "File" to `String` code (which should have a copy in the
Main module, later).
