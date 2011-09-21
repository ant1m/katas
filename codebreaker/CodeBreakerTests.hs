module CodeBreakerTests where

import Test.HUnit
import CodeBreaker

tests = 
  TestList ["" ~?= (mark "rrrr" "gggg"),
            True ~?= True] 
main = do runTestTT tests
