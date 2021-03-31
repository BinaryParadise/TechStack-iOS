import XCTest
@testable import SwiftPodLib

final class SwiftPodLibTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftPodLib().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
