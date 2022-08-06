import XCTest
@testable import FHExtensions

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

final class AppKitTests: XCTestCase {
    
    func testHexColor() throws {
        let hex6With = try XCTUnwrap(NSColor(hex: "#80ff00"))
        let hex6Without = try XCTUnwrap(NSColor(hex: "80ff00"))
        let hex8With = try XCTUnwrap(NSColor(hex: "#80ff00ff"))
        let hex8Without = try XCTUnwrap(NSColor(hex: "80ff00ff"))
        
        for color in [hex6With, hex6Without, hex8With, hex8Without] {
            XCTAssertEqual(color.red, 0.5, accuracy: 0.01)
            XCTAssertEqual(color.green, 1, accuracy: 0.01)
            XCTAssertEqual(color.blue, 0, accuracy: 0.01)
            XCTAssertEqual(color.alpha, 1, accuracy: 0.01)
        }
        
        XCTAssertNotNil(NSColor(hex: "#80FF00"))
        XCTAssertNil(NSColor(hex: "#80ff0"))
        XCTAssertNil(NSColor(hex: "#80ff00f"))
        XCTAssertNil(NSColor(hex: "#80ff00fff"))
        
        XCTAssertEqual(hex6With.createHex(alpha: false, hashSymbol: false), "80ff00")
        XCTAssertEqual(hex6Without.createHex(alpha: false, hashSymbol: true), "#80ff00")
        XCTAssertEqual(hex8With.createHex(alpha: true, hashSymbol: false), "80ff00ff")
        XCTAssertEqual(hex8Without.createHex(alpha: true, hashSymbol: true), "#80ff00ff")
    }
}

#endif // canImport(AppKit) && !targetEnvironment(macCatalyst)
