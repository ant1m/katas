String calculator kata
===

The description can be found [here](http://osherove.com/tdd-kata-1/).

## Lessons learned 
* The delimiter thing doesn't make a lot of sense, regexp do the job.
* Exceptions in r5rs scheme are very low level. Scheme implementations all have higher level exceptions systems, but for some obscure reason I prefer to stick to the standard, even if there is no way the code can be portable.
* Scheme is cool.
* I began this in Racket, but the lack of support for emacs (even with quack) bored me, so I switched to Chicken. DrRacket is nice, but it's no emacs. Having to switch to scheme repl to eval a file is very tedious. Maybe a quack patch could do the job.
* TDD in Scheme may be weird sometimes. As the language is more expressive, there is sometime a urge of taking things a bit further than the problem needs, and i lose the rhythm sometimes. A not very TDD-friendly thing. I hope that getting better at Scheme coding I'll eventually find my pace and find how to identify and adapt the level of expressiveness a particular situation needs.
* Should do it in Racket just out of curiosity.

