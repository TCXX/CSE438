//: ## Objects
//: Custom data types are the core of object-oriented programming. The majority of the time, you will be working with objects written by others in the iOS frameworks. It's also important to create your own objects that are specific to the tasks of your app.
//:
//: There are two kinds of 'objects' in Swift: classes and structures.
//:
//: ### Classes
//: Classes are similar to classes in other languages, able to inherit from a superclass, hold state, and perform actions. Below is an example of a 'base class', a class that doesn't inherit from any other class.
class Person {
    var name = "Nathan"
    func sayName() {
        print(name)
    }
}
//: To create an instance of this class, we initialize it with `()` after the name of the type:
let person = Person()
person.sayName() // prints "Nathan"
person.name = "Todd"
person.sayName() // prints "Todd"
//: The key benefit of classes is they can be the subclass of another class. They can inhereit all their properties and functions, as well add new ones:
class PersonSubclass: Person {
    func sayNameTwice() {
        sayName()
        sayName()
    }
}
let subclass = PersonSubclass()
subclass.sayNameTwice()
//: ### Structs
//: A structure is similar to a class, except it has less functionality. A struct can do everything a class can except inherit from a superclass. The other key difference between classes and structs is that classes are reference types, and structs are value types.
//: + note: This is a key concept in Swift. Reference types mean that the variable's address is passed around, so it is always the same instance of an object that is referred to. Value types are copied whenever they are passed around. As a result, reference types are better for complex objects like views, while value types are better for simple objects like points or other model objects.
//:
//: Declaring a struct is similar to a class:
struct Point {
    var x: Float
    var y: Float
}
let point = Point(x: 0, y: 0)
//: By default, structs come with a default initializer, as seen above. More about initialization in the sections below.
//:
//: It turns out we've been using structs this whole time! `Int`, `Float`, `Double`, and `String` are all declared as structs in the Swift Standard Library.
//:
//: ### Properties
//: Classes and structs can both store data in properties. We saw previously that the `Person` class had a `name` property. Properties are very powerful, and can do more than just store data.
//:
//: A special type of property is the computed property. This property computes itself when it is accessed, similar to a function call. Take a look at the `area` property on the `Rectangle` struct.
struct Rectangle {
    var width: Float
    var height: Float
    var area: Float {
        return width * height
    }
}
//: The area property is defined by the width and the hieght of the rectangle, so whenever it is accessed, it computes itself based on the current state of the rectangle.
let rect = Rectangle(width: 10, height: 10)
let area = rect.area
//: Properties also have property observers, little functions that will run when a certain event happens on the property. One of the most common is the `didSet` property observer. The code defined in this observer is called whenever a property is set. This is especially useful when you need to update the UI when a model value has changed.
class Label {
    var text: String = "" {
        didSet {
            print("text was set!")
            // update the UI of the label here
        }
    }
}
//: ### Initialization
//: Previously on this page, we've only used default initializers instead of creating our own. The initialization model in Swift is quite complex, and its easiest to avoid custom initializers if possible. However, it is still important to learn the basics.
//:
//: A class/struct can define an initializer with the `init` keyword.
class Animal {
    
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
}
//: An initializer must ensure that all of the object's properties are initialized. This includes members of its superclass. To initialize a superclass, we can call `super.init`:
class Dog: Animal {
    
    var barksALot: Bool
    
    init(barksALot: Bool, name: String, age: Int) {
        self.barksALot = barksALot
        super.init(name: name, age: age)
    }
    
}
//: + callout(Let's Create a Data Type): We are building the next big social media app, and we have the concept of "posts". A user can create a "post" and share it with their friends. A "post" consists of a title, message, author name, and the number of likes it has. Create a `Post` object below to help keep track of this data in the app. (Should this be a `class` or a `struct`?)
class Post{
    var title:String
    var message:String
    var author:String
    var likes:Int
    
    init(t:String,m:String,a:String){
        title=t
        message=m
        author=a
        likes=0
    }
}
//: ### Other Topics
//: There are more topics related to objects that are not covered here. These include overriding functions and properties of a superclass, access modifiers, static methods, get/set properties, and other types of initializers. For more information on these topics, consult the Swift Porgramming Language Guide online.
//:
//: [Previous](@previous) | [Next](@next)
//:
//: [Welcome](Welcome) - [Variables](Variables) - [Collections](Collections) - [Control Flow](Control%20Flow) - [Optionals](Optionals) - [Functions](Functions) - Objects - [Enums](Enums) - [Closures](Closures) - [Protocols](Protocols) - [Errors](Errors) - [Extensions](Extensions) - [UIKit](UIKit)
//: - - -
runTests(on: ObjectsTests.self)
//:
import XCTest
extension ObjectsTests {
    
    func test1Post() {
        let post: Post? = nil
        XCTAssertTrue(post == nil)
    }
    
}
