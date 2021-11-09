import XCTest
@testable import FHExtensions

#if canImport(UIKit)
import UIKit

final class UIKitTests: XCTestCase {
    
    func testRGBColors() {
        let color = UIColor(red: 10/255, green: 20/255, blue: 30/255, alpha: 0.5)
        
        XCTAssertEqual(color.red, 10/255)
        XCTAssertEqual(color.green, 20/255)
        XCTAssertEqual(color.blue, 30/255)
        XCTAssertEqual(color.alpha, 0.5)
    }
    
    func testHexColor() {
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
    }
    
    func testModelIdentifier() {
        XCTAssertNotNil(UIDevice.current.modelIdentifier, "Found model identifier")
    }
}

#endif // canImport(UIKit)
