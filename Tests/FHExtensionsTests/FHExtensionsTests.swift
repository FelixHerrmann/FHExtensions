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
        guard let date = Date(23, 2, 1999, hour: 9, minute: 41, second: 0, timeZone: TimeZone(secondsFromGMT: 0)) else { return }
        
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? .current
        let components = calendar.dateComponents([.second, .minute, .hour, .day, .month, .year, .timeZone], from: date)
        
        XCTAssertEqual(components.second, 0)
        XCTAssertEqual(components.minute, 41)
        XCTAssertEqual(components.hour, 9)
        XCTAssertEqual(components.day, 23)
        XCTAssertEqual(components.month, 2)
        XCTAssertEqual(components.year, 1999)
        XCTAssertEqual(components.timeZone, TimeZone(secondsFromGMT: 0))
    }
    
    func testDateEncodingDecodingStrategy() {
        guard let date = Date(23, 2, 1999, hour: 9, minute: 41, second: 0, timeZone: TimeZone(secondsFromGMT: 0)) else { return }
        
        if #available(OSX 10.13, iOS 11.0, tvOS 11.0, *) {
            let encoder = JSONEncoder()
            let decoder = JSONDecoder()
            
            encoder.dateEncodingStrategy = .iso8601withFractionalSeconds
            decoder.dateDecodingStrategy = .iso8601withFractionalSeconds
            
            guard let data = try? encoder.encode(date) else { return }
            
            if let dateString = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? String {
                XCTAssertEqual(dateString, "1999-02-23T09:41:00.000Z")
            }
            
            if let decodedDate = try? decoder.decode(Date.self, from: data) {
                XCTAssertEqual(decodedDate, date)
            }
        }
    }
    
    func testCapitalizeString() {
        let string = "test string"
        
        XCTAssertEqual("Test string", string.capitalizedFirst)
        XCTAssertNotEqual("Test String", string.capitalizedFirst)
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
    
    func testHexColor() {
        #if canImport(UIKit)
        guard let hex6With = UIColor(hex: "#80ff00"),
              let hex6Without = UIColor(hex: "80ff00"),
              let hex8With = UIColor(hex: "#80ff00ff"),
              let hex8Without = UIColor(hex: "80ff00ff")
        else { return }
        
        for color in [hex6With, hex6Without, hex8With, hex8Without] {
            XCTAssertEqual(color.red, 0.5, accuracy: 0.01)
            XCTAssertEqual(color.green, 1, accuracy: 0.01)
            XCTAssertEqual(color.blue, 0, accuracy: 0.01)
            XCTAssertEqual(color.alpha, 1, accuracy: 0.01)
        }
        
        XCTAssertNotNil(UIColor(hex: "#80FF00"))
        XCTAssertNil(UIColor(hex: "#80ff0"))
        XCTAssertNil(UIColor(hex: "#80ff00f"))
        XCTAssertNil(UIColor(hex: "#80ff00fff"))
        
        
        XCTAssertEqual(hex6With.createHex(alpha: false, hashSymbol: false), "80ff00")
        XCTAssertEqual(hex6Without.createHex(alpha: false, hashSymbol: true), "#80ff00")
        XCTAssertEqual(hex8With.createHex(alpha: true, hashSymbol: false), "80ff00ff")
        XCTAssertEqual(hex8Without.createHex(alpha: true, hashSymbol: true), "#80ff00ff")
        #endif
    }
    
    func testModelIdentifier() {
        #if canImport(UIKit)
        XCTAssertNotNil(UIDevice.current.modelIdentifier, "Found model identifier")
        #endif
    }
}
