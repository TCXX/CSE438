//: ## Extensions
//: Extensions are one of Swift's best features. They allow you to add functions, computed properties, and static properties to any already existing class, struct, or enum.
//:
//: Let's create a simple struct and add a function in an extension:
struct NameTag {
    var firstName: String
    var lastName: String
}

extension NameTag {
    func fullName() -> String {
        return firstName + " " + lastName
    }
}
//: Well, what's the advatage of this? We could easily just move the function inside the struct declaration instead of creating an extension.
//:
//: An extension provides a few benefits. First, it keeps the original declaration clean. When we look up a `NameTag`, we immidiately see it's just two strings, and don't get distracted by all the helper functions. Second, it allows us to move the extension anywhere in our code, even to a different file. This can help organize our code as it grows.
//:
//: Lastly, extensions allow us to modify objects that we didn't create. Sad that the built-in `Int` type doesn't have an `isEven()` function? Well, you can just add it yourself!
extension Int {
    func isEven() -> Bool {
        return self % 2 == 0
    }
}
//: Now, just call your fancy new method on any instance of `Int`:
7.isEven()
10.isEven()
//: + callout(Extend the String struct): Extend the built-in `String` struct with a function named `removeVowels` that removes all vowels (a, e, i, o, u) from the string.
extension String{
    func removeVowels() -> String {
        //http://stackoverflow.com/questions/36058863/disemvowel-in-swift
        let vowels: [Character] = ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]
        let result = String(self.characters.filter { !vowels.contains($0) })
        return result
    }
}
//:
//: [Previous](@previous) | [Next](@next)
//:
//: [Welcome](Welcome) - [Variables](Variables) - [Collections](Collections) - [Control Flow](Control%20Flow) - [Optionals](Optionals) - [Functions](Functions) - [Objects](Objects) - [Enums](Enums) - [Closures](Closures) - [Protocols](Protocols) - [Errors](Errors) - Extensions - [UIKit](UIKit)
//: - - -
runTests(on: ExtensionsTests.self)
//:
import XCTest
extension ExtensionsTests {
    
    func test1Vowels() {
        XCTAssertEqual("hello".removeVowels(), "hll")
    }
    
}
