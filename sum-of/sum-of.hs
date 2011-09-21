module Main where

fizzbuzz :: Int -> String
fizzbuzz x = 
  case (by3, by5) of
    (True, True) -> "Fizzbuzz"
    (False, True) -> "Buzz"
    (True, False) -> "Fizz"
    (_,_) -> show x
  where 
    by3 = x `mod` 3 == 0
    by5 = x `mod` 5 == 0
