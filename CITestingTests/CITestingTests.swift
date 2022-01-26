

import XCTest
@testable import CITesting

class CITestingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testStringToInt() {
        let vv = ViewController()
        let num = vv.stringToInt(string: "12")
        XCTAssertEqual(12, num)
    }
    func testStringToIntWithInvalidData() {
        let vv = ViewController()
        let num = vv.stringToInt(string: "Leo")
        XCTAssertEqual(0, num)
    }
    func testHelloWorld() {
        let vv = ViewController()
        let num = vv.getHelloWorld()
        XCTAssertEqual("Hello World", num)
    }
}
