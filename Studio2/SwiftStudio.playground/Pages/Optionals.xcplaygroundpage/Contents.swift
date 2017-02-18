//: ## Optionals
//: Everything we've seen so far is relatively common to most programming languages. The syntax might be slightly different, but the concepts are the same. Optionals are different.
//:
//: Swift can feel strict to new users beacuse many errors are checked at compile time instead of run time. This is a good thing, since it gives a stronger guarantee about the correctness of your code as you write it. However, it can feel frustrating to constantly get error messages and warnings. Optionals are particularly notorious for giving error messages (you will see why soon). With patience, you can write incredibly safe code, but it will take some learning to get there.
//:
//: Many languages have the concept of `null`, the absence of a value. In Swift, this is called `nil`. In a language like Java, any object can be `null`. In Swift, in order for an object to be `nil`, it must be of the `Optional` type. This means we can get a compile-time guarantee about the nullability of objects! This is absolutely incredible and one of the core benefits of Swift.
//:
//: In order to declare an optional, write a `?` after the type name.
var optionalInt: Int?
//: This is saying that we have a variable that is either an `Int`, or it's `nil`. If we don't assign a value, by default the value is `nil`.
//:
//: If we try to use our fancy new `optionalInt`, we get an error:
//let sum = 3 + optionalInt
//: The error is saying that the value is not 'unwrapped'. But, it comes with a handy fix-it: to unwrap the value, add an `!` after the variable:
//let newSum = 3 + optionalInt!
//: If you add the `!` to the first line above (so it matches the lower line), we get a new error: `EXC_BAD_INSTRUCTION`. In other words, the program crashed.
//:
//: Why is this? The `!` is used to 'force-unwrap' an optional value. Whenever you type this, you are telling the compiler that you are **sure** that the value is not `nil`, so don't worry about it and compile anyways. If the value is `nil`, the program has no path of execution, and the best option is to terminate itself.
//:
//: This is bad.
//:
//: Luckily, there are lots of ways to avoid this. All of the following methods are safe ways to unwrap an optional. They are all just syntax describing how to react if a value is `nil`.
//:
//: ### if != nil
//: The simplest way to unwrap an optional is to directly check it with an if statement.
var optionalString: String? = "hello"
if optionalString != nil {
    print(optionalString!)
}
//: In this case, force-unwrapping the optional is fine, since we previously checked that it was not `nil`. This is not the best solution, since there is no direct connection between the if statement and the unwrapping. If the code gets changed later, this could easily break.
//:
//: ### if let
//: Because of the fragility of the above solution, Swift has an `if let` syntax that allows for a direct connection and re-assignment of this optional value.
if let unwrappedString = optionalString {
    print(unwrappedString)
}
//: This is saying, "if `optionalString` is not nil, assign its unwrapped (non-optional) value to `unwrappedString`." This is an improvement over the `if != nil` syntax because it removes the need to use the `!`, which can cause crashes.
//:
//: ### guard
//: `if let` statements are great, and are used frequently. One of their issues is that the unwrapped variable remains inside the scope of the `{}`. This can lead to the horrifying "pyramid of doom":
var a, b, c, d: Int?
if let a = a {
    if let b = b {
        if let c = c {
            if let d = d {
                // update the UI here
            }
        }
    }
}
//: This occurs because we handle the 'good' case inside the `{}` and let the 'bad' case fall to the `else` condition. `guard` statements flip this around, handling the `nil` case first and letting the unwrapped value enter the outer scope.
import Foundation // required for the 'exit(1)' hack below
guard let unwrappedString = optionalString else {
    print("oh no, optionalString is nil")
    exit(1) // normally this would be 'return' or 'break', but 'exit(1)' is written because playgrounds execute code at the 'global scope', something not possible in a normal app.
}
print(unwrappedString)
//: Guard statements are incresingly becoming the go-to method for unwrapping optionals in Swift.
//:
//: ### ??
//: Another great trick to unwrap optionals is to use the nil coalescing operator, `??`. This provides a default value in case the variable is `nil`.
let myString = optionalString ?? "" // if the string is nil, use the empty string instead
//: + callout(Optionals are fun?): Add the following two numbers to the `total` variable.
var total = 0
let first: Int? = 400
let second: Int? = 38
total = first! + second!

//:
//: ### Why Use Optionals?
//: It seems like optionals exist just to make our life complicated, and introduce lots of new syntax. Why would we ever use optionals in the first place?
//:
//: Optionals only exist when they are intentionally used in an API. Even in the Swift standard library, there are many times when an optional seems natural. Consider a dictionary from earlier.
let dictionary = ["a": 1, "b": 3, "c": 7]
//: What happens if we try to access a key-value pair that doesn't exist? Well, we could crash the program like accessing an out of bounds index like an array would, but this kind of operation doesn't feel as severe. Instead, the dictionary always returns an optional when accessing values by a key. If the does not exist, the value is `nil`.
let nonExistantEntry = dictionary["d"]
//: To check the type of `nonExistantEntry`, hold Option on your keyboard and click the variable name. A popup should appear that displays its type as `Int?`.
//:
//: We will see optionals throughout the rest of the semester. Any time an optional appears is a good chance to understand what case is causing it to be optional (maybe no image exists at a url, a `String` might not be convertable into a `Double`, etc). Simply adding an `!` to all your optionals is merely pushing potential errors from compile time to run time and will only cause more work later.
//:
//: [Previous](@previous) | [Next](@next)
//:
//: [Welcome](Welcome) - [Variables](Variables) - [Collections](Collections) - [Control Flow](Control%20Flow) - Optionals - [Functions](Functions) - [Objects](Objects) - [Enums](Enums) - [Closures](Closures) - [Protocols](Protocols) - [Errors](Errors) - [Extensions](Extensions) - [UIKit](UIKit)
//: - - -
runTests(on: OptionalsTests.self)
//:
import XCTest
extension OptionalsTests {
    
    func test1Add() {
        XCTAssertEqual(total, 438)
    }
    
}
