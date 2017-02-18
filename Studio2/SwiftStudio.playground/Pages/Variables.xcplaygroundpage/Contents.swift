//: ## Variables
//: Variables in Swift are delacred using the `let` and `var` kewords. `let` decalres a constant, and `var` decalres a variable.
let myConstant = 0
var myVariable = 0
//: Swift has type-inference, meaning the compiler will automatically assume the type based on the contents of the variable.
let myString = "hello" // inferred as a String
let myInt = 1 // inferred as an Int
let myDouble = 0.5 // inferred as a Double
//: To explicity indicate a variable's type, write the type's name after a colon.
let nowADouble: Double = 1
let forSureAString: String = "hi"
//: Swift is statically typed. Once a variable is declared, it cannot be assigned to a variable of a different type. Uncomment the line below to see for yourself.
var apples = 3
//apples = "hello, world" //error
//: In order to convert between types, variables must be explicitly converted. Many simple Swift types have a constructor that takes in variables of other types. (Variables can also be casted using the `as` keyword, which will be covered on the Optionals page.)
let text = "My favorite class is CSE"
let courseNumber = 438
let message = text + String(courseNumber)
//: Strings have a special syntax which allows them to be more easily combined. Escape an expression within `\()` to interpolate it into the string.
let numUnreadEmails = 12
let newMessage = "I have \(numUnreadEmails) unread emails!"
//: + note: This technique is especially useful when printing debug messages to the console.
//: \
//: `print("width = \(width)")`
//:
//: Swift includes many basic types including `String`, `Int`, `Double`, `Float`, `Character`, `Bool`, etc. These are all declared as a `struct` (a type of object we will see later).
//: + callout(Try it Yourself!): Declare a constant below named `myFloat` of type `Float` and set it equal to `0`.
let myFloat:Float=0
//: Swift code supports the entire Unicode character set, which means your variable names aren't limited to the tradational ASCII characters. This allows for code like:
let π = 3.14159
let 你好 = "hello"
//: And yes, this means that emojis work as well.
let 😂😍😎 = "Yes, this actually compiles. 😯"
//: + note: Naming conventions are important in Swift. As you've seen already, types are written starting with a capital letter (`Int`, `String`), and variables start with a lowercase letter (`myVariable`, `newMessage`).
//:
//: [Previous](@previous) | [Next](@next)
//:
//: [Welcome](Welcome) - Variables - [Collections](Collections) - [Control Flow](Control%20Flow) - [Optionals](Optionals) - [Functions](Functions) - [Objects](Objects) - [Enums](Enums) - [Closures](Closures) - [Protocols](Protocols) - [Errors](Errors) - [Extensions](Extensions) - [UIKit](UIKit)
//: - - -
runTests(on: VariablesTests.self)
//:
import XCTest
extension VariablesTests {
    
    func test1Float() {
        XCTAssertEqual(myFloat, Float(0))
    }
    
}
