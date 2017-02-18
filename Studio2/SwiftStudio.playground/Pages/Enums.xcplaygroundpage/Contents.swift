//: ## Enums
//: Enumerations in Swift are more powerful than enumerations in other programming languages. They are similar to classes and structs becuase they can have methods and computed properties. The main difference is that enums cannot hold any state (cannot have any non-computed, non-static properites) because the 'state' of an enum is defined by its cases. Enums are used for data types that have a small, finite number of possibilities.
//:
//: To declare an enum, use the `enum` keyword:
enum Direction {
    case up
    case down
    case left
    case right
}
//: An instance of an enum can be created by accessing one of its cases.
let direction = Direction.up
//: If the type of an enum is known, the compiler can infer its type, and the enum's type name can be removed:
let anotherDirection: Direction = .up
//: Enums can have an associated type. This is just a mapping between an enum case and a value of some type.
enum ErrorCode: Int {
    case success = 200
    case notFound = 404
}
//: The associated value of an enum can be accessed through the `rawValue` property:
let code = ErrorCode.success.rawValue
//: Enums work particularly well with `switch` statements. Because an enum has a definaed number of states, we can get a compile-time guarantee that all our cases are covered with a switch statement. Notice how no default case is required because all of the enum's cases have been covered.
switch direction {
case .up:
    print("up!")
case .down:
    print("down!")
case .right:
    print("right!")
case .left:
    print("left!")
}
//: Since enums can also have methods, we can use this in combination with a switch statement to map multiple different pieces of information to enum cases.
enum Suit {
    
    case spades, clubs, hearts, diamonds
    
    func emoji() -> String {
        switch self {
        case .spades:
            return "♠️"
        case .clubs:
            return "♣️"
        case .hearts:
            return "♥️"
        case .diamonds:
            return "♦️"
        }
    }
    
}
let spadesEmoji = Suit.spades.emoji()
//: + callout(Rock Paper Scissors): Create an enum named `RPSOption` that defines the three options in a game of rock, paper, scissors.
enum RPSOption{
    case rock
    case paper
    case scissors
}
//: Enums have many more advanced features, including asymmetric associated types and pattern matching features. If you would like to learn more, consult the Swift Programming Language book online.
//:
//: [Previous](@previous) | [Next](@next)
//:
//: [Welcome](Welcome) - [Variables](Variables) - [Collections](Collections) - [Control Flow](Control%20Flow) - [Optionals](Optionals) - [Functions](Functions) - [Objects](Objects) - Enums - [Closures](Closures) - [Protocols](Protocols) - [Errors](Errors) - [Extensions](Extensions) - [UIKit](UIKit)
//: - - -
runTests(on: EnumsTests.self)
//:
import XCTest
extension EnumsTests {
    
    func test1RPS() {
        let rock = RPSOption.rock
        let paper = RPSOption.paper
        let scissors = RPSOption.scissors
        XCTAssertTrue(true)
    }
    
}
