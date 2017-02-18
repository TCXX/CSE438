//: ## Protocols
//: Protocols are types that define requirements of certain properties or functions. (They are similar to Interfaces in Java).
protocol MyProtocol {
    func requiredFunction()
}
//: An object 'conforms' to a protocol by 'adopting' it similarly to how a class inherits from a superclass:
class MyClass: MyProtocol {
    func requiredFunction() {
        // do something here
    }
}
//: If an object conforms to a protocol, it must implement all of the protocol's functions and properties or else it won't compile. Classes, structs, and enums can all adopt protocols:
struct MyStruct: MyProtocol {
    func requiredFunction() {}
}
enum MyEnum: MyProtocol {
    func requiredFunction() {}
}
//: + note: Objects can conform to multiple protocols. Classes can inherit from only a single superclass, but can conform to multiple protocols. To do this, write each superclass/protocol after the colon, seperated by commas:
//: \
//: `class MyClass: SuperClass, MyProtocol, AnotherProtocol {`
//:
//:
//: One way to think about protocols is that they describe the ability of objects. Let's create an example where we describe objects that are able to be baked.
protocol Bakeable {
    func bake()
}
//: Now we can give some objects the ability to bake:
class Cake: Bakeable {
    var description = "🍰"
    func bake() {
        print("baking the cake 🍰")
    }
    
}
struct Pizza: Bakeable {
    func bake() {
        print("mmm pizza 🍕")
    }
}
//: Why bother creating a protocol? We could have simply defined these methods on each object independently. The benefit of protocols is that they can be used to group objects of similar ability as well as hide implementation except for what is needed.
let cake = Cake()
let pizza = Pizza()
let itemsToBake: [Bakeable] = [cake, pizza] // this is an array of `Bakeable` items
for item in itemsToBake {
    item.bake()
}
//: If we were to create an `Oven` class, we could have it bake an array of `Bakeable` items and we would have a compile-time guarantee that each item can be baked. Additionally, if the `Cake` struct was very complex, we would guarantee that the `Oven` wouldn't be able to do anything to anything to our cake except bake it (like changing the color of the frosting). This helps keep our code clean, readbale, and bug free.
class Oven {
    func heat(items: [Bakeable]) {
        for item in items {
            item.bake()
        }
    }
}
//: Protocols are used throughout the Swift Standard Library, but one in particular is the protocol `CustomStringConvertible`. The `print()` function uses the `description` property of this protocol to output a nice representation of an object. Let's try adopting this protocol for an example object:
struct Point: CustomStringConvertible {
    var x: Float
    var y: Float
    
    var description: String {
        return "(\(x), \(y))"
    }
}
print(Point(x: 3, y: 7.5))
//: + callout(Custom Strings for All the Things!): Modify the `Cake` class above to conform to the `CustomStringConvertible` protocol. When a cake object is printed, make it print the cake emoji (🍰) instead of the class name.
print(Cake())
//: Some protocols we will see later in the course have optional methods that are not requied but provide additional functionality if they are implemented. Protocols can also be used to provide default implementations, giving inheritance-like abilities to structs and enums. These are called protocol extensions, and like generics and custom operators, they are out of scope for this course. If you would like to learn about them, consult the Swift Porgramming Language guide online.
//:
//: [Previous](@previous) | [Next](@next)
//:
//: [Welcome](Welcome) - [Variables](Variables) - [Collections](Collections) - [Control Flow](Control%20Flow) - [Optionals](Optionals) - [Functions](Functions) - [Objects](Objects) - [Enums](Enums) - [Closures](Closures) - Protocols - [Errors](Errors) - [Extensions](Extensions) - [UIKit](UIKit)
//: - - -
runTests(on: ProtocolsTests.self)
//:
import XCTest
extension ProtocolsTests {
    
    func test1Cake() {
        XCTAssertEqual(Cake().description, "🍰")
    }
    
}
