import XCTest
@testable import FHExtensions

#if os(iOS) || os(tvOS) || os(watchOS) || targetEnvironment(macCatalyst)
import UIKit
#endif

final class FHExtensionsTests: XCTestCase {
    func testArraySafe() {
        let array: [String] = ["test", "test2"]
        
        XCTAssertEqual(array[safe: 1], "test2")
        XCTAssertNil(array[safe: 2], "value is nill")
    }
    
    func testRGBColors() {
        #if os(iOS) || os(tvOS) || os(watchOS) || targetEnvironment(macCatalyst)
        let color = UIColor(red: 10, green: 20, blue: 30, alpha: 0.5)
        
        XCTAssertEqual(color.red, 10)
        XCTAssertEqual(color.green, 20)
        XCTAssertEqual(color.blue, 30)
        XCTAssertEqual(color.alpha, 0.5)
        #endif
    }
    
    func testModelIdentifier() {
        #if os(iOS) || os(tvOS) || os(watchOS) || targetEnvironment(macCatalyst)
        XCTAssertNotNil(UIDevice.current.modelIdentifier, "Found model identifier")
        #endif
    }
    
    static var allTests = [
        ("rgbColors", testRGBColors),
        ("modelIdentifier", testModelIdentifier)
    ]
}
