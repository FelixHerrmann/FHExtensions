import XCTest
@testable import FHExtensions

import Foundation

final class FoundationTests: XCTestCase {
    
    func testArraySafe() {
        var array: [String] = ["test", "test2"]
        
        XCTAssertEqual(array[safe: 1], "test2")
        XCTAssertNil(array[safe: 2])
        
        array[safe: 1] = "test3"
        XCTAssertEqual(array[safe: 1], "test3")
        
        array[safe: 2] = "test4"
        XCTAssertNil(array[safe: 2])
    }
    
    func testBundleNumbers() {
        let bundle = Bundle.main
        
        XCTAssertNotNil(bundle.buildNumber)
        XCTAssertNotNil(bundle.versionNumber)
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
        
        if #available(macOS 10.13, iOS 11.0, tvOS 11.0, *) {
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
        
        XCTAssertEqual(string.capitalizedFirst, "Test string")
        XCTAssertNotEqual(string.capitalizedFirst, "Test String")
    }
}
