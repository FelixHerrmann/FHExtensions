import XCTest
@testable import FHExtensions

#if canImport(CoreGraphics)
import CoreGraphics

final class CoreGraphicsTests: XCTestCase {
    
    func testRectHelpers() {
        var rect = CGRect(x: 10, y: 10, width: 20, height: 20)
        
        XCTAssertEqual(rect.x, 10)
        XCTAssertEqual(rect.y, 10)
        XCTAssertEqual(rect.top, 10)
        XCTAssertEqual(rect.bottom, 30)
        XCTAssertEqual(rect.left, 10)
        XCTAssertEqual(rect.right, 30)
        XCTAssertEqual(rect.center, CGPoint(x: 20, y: 20))
        
        rect.top = -10
        rect.left = -10
        rect.size.height = 30
        rect.size.width = 40
        
        XCTAssertEqual(rect.x, -10)
        XCTAssertEqual(rect.y, -10)
        XCTAssertEqual(rect.bottom, 20)
        XCTAssertEqual(rect.right, 30)
        
        rect.center.x += 5
        
        XCTAssertEqual(rect.x, -5)
        XCTAssertEqual(rect.y, -10)
    }
}

#endif // canImport(CoreGraphics)
