using sys::Test

class FizzBuzzTest : Test
{
  Void testFizzBuzz1Equals1(){
    verifyEq(FizzBuzz.fizzBuzz(1), "1")
  }
  
  Void testFizzBuzz2Equals2(){
    verifyEq(FizzBuzz.fizzBuzz(2), "2")
  }
  
   Void testFizzBuzz3EqualsFizz(){
    verifyEq(FizzBuzz.fizzBuzz(3), "Fizz")}
      
   Void testFizzBuzz5EqualsBuzz(){
    verifyEq(FizzBuzz.fizzBuzz(5), "Buzz")
   }
  
  Void testFizzBuzz15EqualsFizzBuzz(){
    verifyEq(FizzBuzz.fizzBuzz(15), "FizzBuzz")
   }
  
   Void testFizzBuzz30EqualsFizzBuzz(){
    verifyEq(FizzBuzz.fizzBuzz(30), "FizzBuzz")
   }
  
   Void testFizzBuzz6EqualsFizz(){
    verifyEq(FizzBuzz.fizzBuzz(6), "Fizz")
   }
  
  Void testFizzBuzz10EqualsFizz(){
    verifyEq(FizzBuzz.fizzBuzz(10), "Buzz")
   }
}
