Args
===

This is a kata that you can find [here](http://codingdojo.org/cgi-bin/wiki.pl?KataArgs). Bob Martin solution in java is [here](https://github.com/unclebob/javaargs/tree/master/src/com/objectmentor/utilities/args), longer but more features.

## Lessons learned
* Hashmaps in racket are nice but they are not a list of pairs, so no car or cdr.
* I came to make a small proto-object to handle specs, but OO means imperative. It's often fast and convenient, but not far from quick and dirty.
* At first the simplest solution that came out was the very imperative parse* function. During a refactoring in the end I came to a more functional thing by creating a utility function used to map a function over a hashmap. I kept parse* as a reminder.
* I could have spent time clearly defining the entities used in the program : flags, argument values, default values, etc, but the timebox was over. Maybe next time.
