//: # Studio: Swift
//: ## CSE 438: Mobile Application Development
//: ### Overview
//: In this studio, you will get first-hand experience with the Swift programming language. Investing the time now will pay off later in the course as the projects increase in complexity. I *highly* reccomend completing this entire studio even if you don't finish by the end of class.
//: ### Details
//: **Due:** End of class today. \
//: **Grading:** Complete as much of the studio as you can to get credit. \
//: **Submission:** Zip the playground and email it to cse438ta@gmail.com. Please name the file "FirstNameLastName-Studio2.zip".
//: ### Activities
//: This playground will guide you through the basic concepts of the Swift programming language. The goal is to quickly introduce the most important concepts so you can build cool apps. For a complete guide, check out the official Swift Language Guide: [The Swift Programming Language.](http://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/)
//: \
//: \
//: Playgrounds are a great way to experiment with code without all the complexity of the Xcode IDE. It also is a great tool to visualize your code. The right sidebar shows the current state of variables, and hovering over one and selecting the Quick Look icon will show a visual representation of the value.
//: \
//: \
//: ![Quick Look Button](quicklook.png)
//: \
//: \
//: Try this with the image below. You should see an image of the Swift logo.
import UIKit
let swift = UIImage(named: "swift")
//: The goal is for this playground to be interactive! You can edit any code and try new things as you learn. At the bottom of each page is a `runTests` line which displays the results of various tests. These tests will pass if you complete the various activities throughout the page. Each activity is noted by a green callout and has a corresponding test. Try the example below:
//: + callout(Example): Set the variable `hello` equal to the string `"hello"`.
var hello:String = "hello"
//: If you complete this correctly, you should see a green check emoji (✅) appear on the right side bar next to the line `runTests` in place of a red x (❌). The order of the tests at the very bottom of each page matches the order of the emojis. These tests exist purely to aid your learning and help confirm that you've implemented concepts correctly. Feel free to complete as many as you choose.
//:
//: Most of the tests are commented out because they cause compile-time errors. Once you have completed the exercises, un-comment the test and it will automatically run. Try uncommenting the freebie test below. (Pro tip: Command-/ will comment/uncomment the current line or a group of lines)
import XCTest
extension WelcomeTests {
    func test0freebie() {
        XCTAssertEqual(true, true)
    }
}
//: \
//: \
//: To navigate between pages, use the links at the bottom of each page. Click the "Next" button below to get started.
//: \
//: \
//: [Previous](@previous) | [Next](@next)
//:
//: Welcome - [Variables](Variables) - [Collections](Collections) - [Control Flow](Control%20Flow) - [Optionals](Optionals) - [Functions](Functions) - [Objects](Objects) - [Enums](Enums) - [Closures](Closures) - [Protocols](Protocols) - [Errors](Errors) - [Extensions](Extensions) - [UIKit](UIKit)
//: - - -
runTests(on: WelcomeTests.self)
//:
import XCTest
extension WelcomeTests {
    
    func test1Example() {
        XCTAssertEqual(hello, "hello")
    }
    
}
