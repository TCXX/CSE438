//: ## Closures
//: Closures are one of the best features of Swift. They are incredibly powerful and flexible. However, many students struggle with them because of the syntax and reasoning required to use them. Like optionals, with patience and a little bit of practice, you should start to see their benefit.
//:
//: Closures are chunks of code that can be stored in a variable. They can also be described as 'blocks' or 'unnamed functions'. The 'function without a name' is a great way to start to learn about closures, since functions are just a type of closure.
//:
//: Let's grab a simple function from before:
func emphasize(word: String) -> String {
    return word + "!"
}
//: To write this function as a closure, we just move some of the syntax around:
let emphasizeClosure = { (word: String) -> String in
    return word + "!"
}
//: Now we've declared a variable called `emphasize` which is of type `(String) -> String`, meaning it's a closure that takes in a `String` and returns a `String`. We set the variable equal to a set of `{}`. Inside the `{}`, we name the parameters in order (in the case `word`) followed by the keyword `in`. Then, just like a function, we return the modified string.
//:
//: A closure can be executed just like a function:
let result = emphasizeClosure("hello")
//: Let's see an example of a closure in action. An array's `sorted` function takes in a closure that describes how to sort the elements. This closure is of type `(Int, Int) -> Bool`, meaning it takes in two integers (the numbers it is comparing) and returns true or false (true if the first paramter should come before the second).
let numbers = [3,6,2,8,7,9,1,4,5]
let sorted = numbers.sorted(by: { (first: Int, second: Int) -> Bool in
    return first < second
})
//: Now for the cool part. Because of Swift's type inference, we can simplify this closure. To start, we already know the type of the closure, so those type annotations can be removed.
let sortedBetter = numbers.sorted(by: { first, second in
    return first < second
})
//: Next, we can use Swift's default argument names (`$0`, `$1`, `$2`, etc) instead of declaring our own names.
let sortedEvenBetter = numbers.sorted(by: { return $0 < $1 })
//: At this point, it's obvious that we are going to 'return' something, so why bother including that keyword?
let sortedEvenBetterStill = numbers.sorted(by: { $0 < $1 })
//: Can we go further? Of course we can. Just supply the `<` operator.
let sortedBest = numbers.sorted(by: <)
//: This works because the `<` operator in Swift is actually a function, and functions are just closures. Custom operators are beyond the scope of this course, but there is lots of great information online if you are curious.
//: + callout(Simple Closure): Set the type of `simpleClosure` to take in an `Int` and return a `String`. The closure should return the string value of the integer (1 -> "1", 13 -> "13", etc).
let simpleClosure = {(number:Int)->String in String(number)}
//:
//: Closures are able to 'capture' variables around them. This means the code in a closure has access to variables and functions that were available in the scope where the closure was created, even if the closure is in a different scope when it is executed.
func captureExample() -> (() -> Int) {
    let scopedVariable = 3
    return { return scopedVariable }
}
//: The syntax in the `captureExample` function is worth explaining. This function takes in no paramters, and returns a closure of type `() -> Int`, meaning it's a closure that takes in no arguments and returns an integer. The line `return { return scopedVariable }` is returning a closure which is returning an integer.
//:
//: Now we can see this closure in use:
let closure = captureExample()
let myOriginalVariable = closure() // equal to 3, the value of `scopedVariable`
//: How cool is that? The `scopedVariable` value, even though it's limited to the function's scope, is captured by the closure. This property of closures makes them particularly easy to work with.
//:
//: The key benefit of closures is that they improve local reasoning — the ability to understand what code is doing without having to look up other class's documentation. Closures give the ability to pass code around so it's possible to keep relevant code together.
//:
//: [Previous](@previous) | [Next](@next)
//:
//: [Welcome](Welcome) - [Variables](Variables) - [Collections](Collections) - [Control Flow](Control%20Flow) - [Optionals](Optionals) - [Functions](Functions) - [Objects](Objects) - [Enums](Enums) - Closures - [Protocols](Protocols) - [Errors](Errors) - [Extensions](Extensions) - [UIKit](UIKit)
//: - - -
runTests(on: ClosuresTests.self)
//:
import XCTest
extension ClosuresTests {
    
    func test1Simple() {
        XCTAssertEqual(simpleClosure(5), "5")
    }
    
}
