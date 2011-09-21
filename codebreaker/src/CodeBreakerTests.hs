-----------------------------------------------------------------------------
--
-- Module      :  CodeBreakerTests
-- Copyright   :
-- License     :  AllRightsReserved
--
-- Maintainer  :
-- Stability   :
-- Portability :
--
-- |
--
-----------------------------------------------------------------------------

module CodeBreakerTests (

) where
import HUnit

tests =
    test ["test1" ~: "foo 3" ~: 3 ~?= 3]


