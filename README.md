Kata04
======

http://codekata.com/kata/kata04-data-munging/

Evaluation
----------

This time, I was interrupted during the first pomodoro, having finished the actual work (except for the answer) well within 20 minutes.
I decided to go on and do part two in another pomodoro's time.
Finally, I wanted to take some time to make it DRY.  Which was surprisingly easy, seen as I just made some copies to solve part 2.

While refactoring, it was clear that using a class was something I tried to evade, but it helped deduplicating some code.
Using the maybe monad and applicative were the final steps in understanding how this could be really DRY, but I needed to see how to use them, first.

To answer thee, these questions three:

- Q. To what extent did the design decisions you made when writing the original programs make it easier or harder to factor out common code?

    A. Well, I decided to *not* plan ahead for a possible similar solution for part two, just to see what would happen.
    That's why I wanted to avoid having generic parsing code.  In the end, that did not do much good, because the parsing was quite hard to test, and not really type safe.
    Refactoring that was the hardest part, and it ended up being the generic code that I might have written anyway.

    The rest, not much influence.  Everything else was really copy-pasteable or hardly worth extracting.  Yay for FP (I guess)!
    
- Q. Was the way you wrote the second program influenced by writing the first?

    A. Yes.  I just copied the tests and the implementation, tweaking juuuust a bit to handle the different format and return type.
    
- Q. Is factoring out as much common code as possible always a good thing? Did the readability of the programs suffer because of this requirement? How about the maintainability?

    A. This seems a real good thing here.  The code looks very much more readable, because I specify *what's different* for this record type, instead of writing "parse" again, but differently.
    Maintainability seems up, as well.
    Change a field position?  Just change the number.
    Change the format of the field (e.g. to decimal)?  Just change the record field type.
    
All in all, I'm gonna do this kata again, tomorrow (if time), and write the generic stuff as it comes natural.
Don't fear the type class!
