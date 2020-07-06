import XCTest
@testable import FHExtensions

#if canImport(UIKit)
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
    
    func testDateEncodingDecodingStrategy() {
        guard let date = Date(23, 2, 1999, hour: 9, minute: 41, second: 0) else { return }
        
        if #available(OSX 10.13, iOS 11.0, tvOS 11.0, *) {
            let encoder = JSONEncoder()
            let decoder = JSONDecoder()
            
            encoder.dateEncodingStrategy = .iso8601withFractionalSeconds
            decoder.dateDecodingStrategy = .iso8601withFractionalSeconds
            
            guard let data = try? encoder.encode(date) else { return }
            
            if let dateString = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? String {
                XCTAssertEqual(dateString, "1999-02-23T08:41:00.000Z")
            }
            
            if let decodedDate = try? decoder.decode(Date.self, from: data) {
                XCTAssertEqual(decodedDate, date)
            }
        }
    }
    
    func testRGBColors() {
        #if canImport(UIKit)
        let color = UIColor(red: 10/255, green: 20/255, blue: 30/255, alpha: 0.5)
        
        XCTAssertEqual(color.red, 10/255)
        XCTAssertEqual(color.green, 20/255)
        XCTAssertEqual(color.blue, 30/255)
        XCTAssertEqual(color.alpha, 0.5)
        #endif
    }
    
    func testModelIdentifier() {
        #if canImport(UIKit)
        XCTAssertNotNil(UIDevice.current.modelIdentifier, "Found model identifier")
        #endif
    }
    
    @UserDefault("test") var test: String?
    
    func testUserDefault() {
        print("TEST: \(test)")
        test = "test"
        print("TEST: \(test)")
        test = nil
        print("TEST: \(test)")
    }
    
    static var allTests = [
        ("arraySafe", testArraySafe),
        ("dateInit", testDateInit),
        ("dateEncodingDecodingStrategy", testDateEncodingDecodingStrategy),
        ("rgbColors", testRGBColors),
        ("modelIdentifier", testModelIdentifier),
        ("userDefault", testUserDefault)
    ]
}
