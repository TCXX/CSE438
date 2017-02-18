//: ## Functions
//: Functions are a way to encapsulate behavior in Swift.
//:
//: To declare a function, use the keyword `func` followed by the function's name:
func sayHello() {
    print("hello")
}
//: To call the function, write its name fallowed by `()`:
sayHello()
//: Functions can have inputs (arguments) and outputs (return types). Here is an example function that adds a "!" to the end of a string:
func emphasize(word: String) -> String {
    return word + "!"
}
//: Functions can also have mutiple arguments and return types:
func multiple(a: Int, b: Int, c: Int) -> (Int, Int) {
    return (a + b, c)
}
let result = multiple(a: 1, b: 2, c: 3)
print(result.0)
print(result.1)
//: + note: The `.0` and `.1` are used is because the function is actually returning a tuple. The variables inside a tuple are accessible by their "index" in the tuple, starting with 0 and increasing. If a tuple was declared with three variables (one: 1, two: 2, three: 3), the third could be accessed with `tuple.2`.
//:
//: Function arguments have labels which describe what the argument is. Each argument actually has two labels, an external label and an internal label. The external label comes first and is written at the call site of the function. The internal label is used within the function.
func example(ext int: Int) {
    print(int)
}
example(ext: 0)
//: What's the purpose of having an internal and external name for arguments? The main reason is that it allows for more readable API's. Take a look at the following example:
func divide(_ numerator: Double, by denominator: Double) -> Double {
    return numerator / denominator
}
let answer = divide(6, by: 3) // how pretty
//: Normally argument labels are required when calling a function. The underscore (`_`) can be used to remove the external label. If only one label is provided, it is used for both the external and internal label.
func noExternalLabel(_ value: Int) {
    print(value)
}
noExternalLabel(0)
//:
//: Because labels provide more clarity to your code, it is generally reccomended to include them.
//: + callout(Let's write a function): Write a function named `isEven` which takes in an `Int` with the label `number` and returns a `Bool`. It should return `true` if the integer is even, and `false` otherwise. (Hint: Swift has the `%` modulo operator.)
func isEven(number:Int) -> Bool{
    return number % 2 == 0
}
//:
//: [Previous](@previous) | [Next](@next)
//:
//: [Welcome](Welcome) - [Variables](Variables) - [Collections](Collections) - [Control Flow](Control%20Flow) - [Optionals](Optionals) - Functions - [Objects](Objects) - [Enums](Enums) - [Closures](Closures) - [Protocols](Protocols) - [Errors](Errors) - [Extensions](Extensions) - [UIKit](UIKit)
//: - - -
runTests(on: FunctionsTests.self)
//:
import XCTest
extension FunctionsTests {
    
    func test1Function() {
        XCTAssertTrue(isEven(number: 4), true)
        XCTAssertTrue(isEven(number: 3), false)
    }
    
}
