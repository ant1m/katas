
class FizzBuzz
{
  static Str fizzBuzz(Int x){
    if (x.mod(15) == 0) {return "FizzBuzz"}
    else if (x.mod(5) == 0) {return "Buzz"}
    else if (x.mod(3) == 0) {return "Fizz"} 
    else {return "$x"}
  }
  
  static Str fizzBuzzResult() {
    (1..100).map |Int integer->Str| { return FizzBuzz.fizzBuzz(integer).toStr }.reduce("") |Str val1, Str val2->Str| { val1 + " " + val2 }
  }
  
  static Void main() {
    echo (fizzBuzzResult())
  }
}
