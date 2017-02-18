import XCTest

/// Executes the tests for a given class, returning a pretty output of the results.
public func runTests(on type: AnyClass) -> String {
    guard let tests = type as? XCTestCase.Type else { return "" }
    let testSuite = tests.defaultTestSuite()
    testSuite.run()
    guard let run = testSuite.testRun as? XCTestSuiteRun else { return "" }
    return prettyPrintResults(from: run)
}

/// Converts a test run into a pretty string result.
func prettyPrintResults(from suiteRun: XCTestSuiteRun) -> String {
    var output = ""
    for run in suiteRun.testRuns {
        output += run.hasSucceeded ? "✅" : "❌"
    }
    return output
}
