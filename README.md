Kata04
======

http://codekata.com/kata/kata04-data-munging/

Evaluation
----------

Of course, part One and Two fit in one pomodoro now.
Part three, refactoring, walked the same steps as last time, except that it felt not so wrong to introduce `query` (later `queryFirst`).

I tried using a method to determine the way to split the input before passing it to `parseWords` (to become `parseFields`), but `String -> [String]` does not really resolve the `Record l r` that goes with it.

Well, maybe tomorrow :)
