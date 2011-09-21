FizzBuzz in fantom
==================

This is the well known FizzBuzz kata, written in the [fantom language](http://fantom.org/). This is a pretty cool language, it makes me think of [Racket](http://racket-lang.org/) without the parentheses (note that I like those parentheses). I couldn't resist to write a very lispy one liner to generate the string to display :p

I wrote the kata using the [F4](http://www.xored.com/f4). It's nice, built on Eclipse, and written in fantom, without a line of Java (says the developers). The 1.0 release was pushed today. Here are the rough edges i noticed : 

  1. the test results are displayed in a dedicated view but f4 automatically switches to the console view,

  2. running the tests on a bugged code base runs the last succeeding tests, i guess because the interpreted doesn't exit properly,

  3. Sometimes the description of a syntax error is quite terse (on the interpreter side, I guess).


Those things put aside, this IDE is a nice piece of work. A proper robust IDE with project management, good editing and refactoring capabilities, environment configuration and so on will will help Fantom to gain the momentum it deserves.

