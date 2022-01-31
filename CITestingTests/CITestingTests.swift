

import XCTest
@testable import CITesting

class CITestingTests: XCTestCase {

    // func testStringToInt() {
    //     let vv = ViewController()
    //     let num = vv.stringToInt(string: "12")
    //     XCTAssertEqual(12, num)
    // }
    // func testStringToIntWithInvalidData() {
    //     let vv = ViewController()
    //     let num = vv.stringToInt(string: "Leo")
    //     XCTAssertEqual(0, num)
    // }
    func testHelloWorld() {
        let vv = ViewController()
        let num = vv.getHelloWorld()
        XCTAssertEqual("Hello World", num)
    }
}
