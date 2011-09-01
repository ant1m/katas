module Palindrome where

import Test.HUnit
import Data.Char

isPalindrome :: String -> Bool
isPalindrome = 
  let 
    filtreCarCorrects = map toUpper . filter (\a -> isAlpha a)
    estSymetrique x = x == reverse x
  in 
    estSymetrique . filtreCarCorrects

tests = test [
  "test1" ~: "a : palindrome" ~: True ~=? (isPalindrome "a"),
  "test2" ~: "ab : papalindrome" ~: False ~=? (isPalindrome "ab"),
  "test3" ~: "bab : palindrome" ~: True ~=? (isPalindrome "bab"),
  "test3" ~: "b ab : palindrome" ~: True ~=? (isPalindrome "b ab"),
  "test4" ~: "b,a   b : palindrome" ~: True ~=? (isPalindrome "b,a   b"),
  "test5" ~: "Isä, älä myy myymälääsi. : palindrome en finnois" ~: True ~=? (isPalindrome "Isä, älä myy myymälääsi.")]
