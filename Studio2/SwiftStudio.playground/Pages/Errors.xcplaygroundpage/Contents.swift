//: ## Errors
//: Errors! Not fun, but it's important to learn the syntax.
//:
//: Error handling in Swift is really great because Swift is an especially safe langauge. As we've seen previously with static typing, type inference, optionals, enums, switch statements, and more, giving the compiler more information about our code allows it to give us strong guarantees about the code's correctness.
//:
//: An error is defined by any type that conforms to the `Error` protocol. This is most commonly done on enums, since an error is usually a part of a finite set of errors.
enum VendingMachineError: Error {
    case invalidNumber
    case noMoreSoda
    case outOfService
}
//:
//: In order for an error to be thrown in Swift, a function must explicitly say that it can throw an error with the `throws` keyword. In order to throw an error, write the `throw` keyword.
func buy(itemNumber: Int) throws -> String {
    if itemNumber > 20 {
        throw VendingMachineError.invalidNumber
    }
    return "Coke"
}
//: There are a few different ways to handle errors. When we call the `buy` function, we need to do so in a `try-catch` block along with a `try` statement.
do {
    let soda = try buy(itemNumber: 25)
} catch {
    print(error)
}
//: It's also possible to catch different types of errors in a syntax similar to a switch statement.
do {
    let soda = try buy(itemNumber: 25)
} catch VendingMachineError.invalidNumber {
    print("Invalid number")
} catch {
    print(error)
}
//: Errors can also be handled by converting the results into optionals with the `try?` keyword.
let soda = try? buy(itemNumber: 22)
//: If the function throws, the variable will be nil. So instead of the `do-catch` syntax, we can use our fancy optional unwrapping syntax instead.
//: + callout(Vending Machine Errors): Modify the function below called `purchase` so it can possibly throw all three vending machine errors.
func purchase(itemNumber: Int, currentStock: Int, inService: Bool) -> String {
    return "Coke"
}
//:
//: [Previous](@previous) | [Next](@next)
//:
//: [Welcome](Welcome) - [Variables](Variables) - [Collections](Collections) - [Control Flow](Control%20Flow) - [Optionals](Optionals) - [Functions](Functions) - [Objects](Objects) - [Enums](Enums) - [Closures](Closures) - [Protocols](Protocols) - Errors - [Extensions](Extensions) - [UIKit](UIKit)
//: - - -
runTests(on: ErrorsTests.self)
//:
import XCTest
extension ErrorsTests {
    
    func test1Purchase() {
        XCTAssertEqual(purchase(itemNumber: 1, currentStock: 1, inService: true), "Coke")
    }
    
}
