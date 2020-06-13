import XCTest
@testable import FHExtensions

#if os(iOS) || os(tvOS) || os(watchOS) || targetEnvironment(macCatalyst)
import UIKit
#endif

final class FHExtensionsTests: XCTestCase {
    func testArraySafe() {
        var array: [String] = ["test", "test2"]
        
        XCTAssertEqual(array[safe: 1], "test2")
        XCTAssertNil(array[safe: 2], "value is nill")
        
        array[safe: 1] = "test 3"
        XCTAssertEqual(array[safe: 1], "test 3")
    }
    
    func testDateInit() {
        guard let date = Date(23, 2, 1999, hour: 9, minute: 41, second: 0) else { return }
        let components = Calendar.current.dateComponents([.second, .minute, .hour, .day, .month, .year,], from: date)
        
        XCTAssertEqual(components.second, 0)
        XCTAssertEqual(components.minute, 41)
        XCTAssertEqual(components.hour, 9)
        XCTAssertEqual(components.day, 23)
        XCTAssertEqual(components.month, 2)
        XCTAssertEqual(components.year, 1999)
    }
    
    func testRGBColors() {
        #if os(iOS) || os(tvOS) || os(watchOS) || targetEnvironment(macCatalyst)
        let color = UIColor(red: 10/255, green: 20/255, blue: 30/255, alpha: 0.5)
        
        XCTAssertEqual(color.red, 10/255)
        XCTAssertEqual(color.green, 20/255)
        XCTAssertEqual(color.blue, 30/255)
        XCTAssertEqual(color.alpha, 0.5)
        #endif
    }
    
    func testModelIdentifier() {
        #if os(iOS) || os(tvOS) || os(watchOS) || targetEnvironment(macCatalyst)
        XCTAssertNotNil(UIDevice.current.modelIdentifier, "Found model identifier")
        #endif
    }
    
    static var allTests = [
        ("arraySafe", testArraySafe),
        ("dateInit", testDateInit),
        ("rgbColors", testRGBColors),
        ("modelIdentifier", testModelIdentifier)
    ]
}
