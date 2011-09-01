module Main 
       where
import List
import Test.HUnit

result = 
  foldl (++) "" $ intersperse ", " [fizzbuzz x | x <- [1..100]]
                                               
  
fizzbuzz :: Int -> String
fizzbuzz x = 
  case (by3, by5) of
    (True, True) -> "FizzBuzz"
    (True, False) -> "Fizz"
    (False, True) -> "Buzz"
    (_,_) -> show x
    where 
      by3 = x `mod` 3 == 0
      by5 = x `mod` 5 == 0

testz = test [
  "test1" ~: "FizzBuzz 1 égale 1." ~:  "1" ~=? (fizzbuzz 1),
  "test2" ~: "FizzBuzz 3 égale Fizz." ~:  "Fizz" ~=? (fizzbuzz 3),
  "test3" ~: "FizzBuzz 5 égale Buzz." ~:  "Buzz" ~=? (fizzbuzz 5),
  "test4" ~: "FizzBuzz 15 égale FizzBuzz." ~:  "FizzBuzz" ~=? (fizzbuzz 15)]

