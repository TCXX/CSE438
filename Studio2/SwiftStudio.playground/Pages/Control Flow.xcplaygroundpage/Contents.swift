//: ## Control Flow
//: This section covers basic logic implementation: if statements, for loops, while loops, and switch statements.
//: ### If Statements
//: If-else statements work as expected, except they do not require `()` around the condition:
let value = 5
var message = ""
if value >= 0 {
    message = "positive"
} else {
    message = "negative"
}
//: Swift also includes the ternary operator, which assigns a value based a condition. If the condition is `true`, the first value is used. Otherwise, the second value is used.
let myMessage = value > 0 ? "positive" : "negative"
//: + callout(Feel like you're back in CSE131 yet?): Assign `output` to the string `"zero"` if the `number` is `0`. Otherwise, set it to the number (if `number` is `4`, `output` is `"4"`).
var number = 0
if number == 0 {
    message = "zero"
} else {
    message = String(number)
}
//: ### For Loops
//: For loops iterate over a range or collection:
for num in 0 ... 10 {
    print(num)
}

let items = ["apples", "oranges", "pears"]
for item in items {
    print(item)
}
//: Ranges are given by the `...` syntax for an open range, and `..<` for a closed range. (Closed ranges do not include the final element in the set.)
for index in 0 ..< items.count {
    print(index)
}
//: To iterate through both the index and element of an array, use the `.enumerated()` method on the array.
for (index, element) in items.enumerated() {
    print("I have \(element) at \(index)")
}
//: To iterate through all the entries in a dictionary, the syntax is similar:
let dictionary = ["a": 1, "b": 3, "c": 7]
for (key, value) in dictionary {
    print("\(key): \(value)")
}
//: + callout(Add the Numbers): Loop through the array below to add all the numbers in the array.
let numbers = [23, 37, 112, 8, 3, 2, 7, 100, 100, 20, 26]
var total = 0

for n in numbers {
    total+=Int(n)
}
//: ### While Loops
//: While loops execute until a certain condition is met.
var n = 2
while n < 1000 {
    n *= 2
}
//: The condition can also be placed at the end of the loop to always guarantee the loop will run at least once.
var m = 2
repeat {
    m *= 2
} while m < 1000
//: + note: Remember the 'Quick Look' option from before? If you select that for either `n` or `m`, you will see a graph of the value over time!
//:
//:
//: + callout(While Addition): Use a `while` loop to find the sum of the same numbers from the previous array `numbers`.
var whileTotal = 0
var i = 0
var len = numbers.count
repeat {
    whileTotal+=numbers[i]
    i+=1
} while i<len
//: ### Switch Statements
//: Switch statements are an incredibly powerful pattern-matching tool that work great with other components in Swift. They are a replacement for elaborate if-else chains.
let myFavoriteLanguage = "Swift"
switch myFavoriteLanguage {
case "Swift":
    print("Great choice!")
case "Python":
    print("Not bad.")
case "Java":
    print("Really?")
default:
    print("You are a true hipster.")
}
//: The great part about switch statements is that they guarantee that all cases are covered with the `default` case. If all cases are covered inside the switch statement, the `default` case can be removed.
let myBool = true
switch myBool {
case true:
    print("true")
case false:
    print("false")
}
//:
//: [Previous](@previous) | [Next](@next)
//:
//: [Welcome](Welcome) - [Variables](Variables) - [Collections](Collections) - Control Flow - [Optionals](Optionals) - [Functions](Functions) - [Objects](Objects) - [Enums](Enums) - [Closures](Closures) - [Protocols](Protocols) - [Errors](Errors) - [Extensions](Extensions) - [UIKit](UIKit)
//: - - -
runTests(on: ControlFlowTests.self)
//:
import XCTest
extension ControlFlowTests {
    
    func test1If() {
        number = 0
        XCTAssertEqual(message, "zero")
        number = 6
        XCTAssertEqual(message, "6")
    }
    
    func test2Total() {
        XCTAssertEqual(total, 438)
    }
    
    func test3WhileTotal() {
        XCTAssertEqual(whileTotal, 438)
    }
    
}
