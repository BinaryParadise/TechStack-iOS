import XCTest
@testable import HybridLib

final class HybridLibTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(HybridLib().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
