//: ## Collections
//: Arrays and dictionaries are great built-in ways to store groups of data.
//: ### Arrays
//: Arrays are declared using square brackets and can hold objects of the same type.
let array = [0, 1, 2, 3, 4, 5]
//: An item can be selected from an array using a subscript. Like many other languages, the array index starts at 0 and will result in a run-time error if it doesn't exist.
let firstElement = array[0]
//: Empty arrays can be created using the initializer syntax:
var myArray = [Int]() // this is an empty array of integers
//: To modify an array, use the `append` method.
myArray.append(3)
//: The length of the array is defined in the `count` property:
let numElements = myArray.count
//: + callout(Create an Array): Create a new array of strings called `stringArray` with at least 3 elements.
var stringArray=["1","2","3"]
//: ### Dictionaries
//: Dictionaries are similar to arrays, except they are un-ordered and hold key-value pairs.
let dictionary = ["a": 1, "b": 3, "c": 7]
//: Items can be pulled from a dictionary using a subscript with the key.
let bCount = dictionary["b"]
//: Empty dictionaries can be created using the initializer syntax:
var myDictionary = [String: String]() // this is an empty dictionary that maps Strings to Strings
//: To modify a dictionary, use the subscript syntax:
myDictionary["CSE438"] = "Mobile Application Development"
//: + callout(Create a Dictionary): Create a new dictionary called `words` that maps String (keys) to Bool (values).
var words=[String:Bool]()
//: + note: Empty `Array` and `Dictionary` literals are given by `[]` and `[:]` respectively.
//:
//: [Previous](@previous) | [Next](@next)
//:
//: [Welcome](Welcome) - [Variables](Variables) - Collections - [Control Flow](Control%20Flow) - [Optionals](Optionals) - [Functions](Functions) - [Objects](Objects) - [Enums](Enums) - [Closures](Closures) - [Protocols](Protocols) - [Errors](Errors) - [Extensions](Extensions) - [UIKit](UIKit)
//: - - -
runTests(on: CollectionsTests.self)
//:
import XCTest
extension CollectionsTests {
    
    func test1Array() {
        XCTAssertTrue(stringArray is [String])
        XCTAssertTrue(stringArray.count > 2)
    }
    
    func test2Dictionary() {
        XCTAssertTrue(words is [String: Bool])
    }
    
}
