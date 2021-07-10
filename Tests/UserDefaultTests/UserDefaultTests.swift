import XCTest
@testable import FHExtensions


struct CustomType: Codable, UserDefaultStorable, Equatable {
    var string: String
    var int: Int
}

enum RawRepresentableEnumeration: String, UserDefaultStorable {
    case a
    case b
}

extension UserDefaultKey {
    static let test: UserDefaultKey = "com.felixherrmann.FHExtensions.test"
    static let testArray: UserDefaultKey = "com.felixherrmann.FHExtensions.testArray"
    static let testDictionary: UserDefaultKey = "com.felixherrmann.FHExtensions.testDictionary"
    static let testOptional: UserDefaultKey = "com.felixherrmann.FHExtensions.testOptional"
    static let testCodable: UserDefaultKey = "com.felixherrmann.FHExtensions.testCodable"
    static let testEnum: UserDefaultKey = "com.felixherrmann.FHExtensions.testEnum"
}

final class UserDefaultTests: XCTestCase {
    
    func testValueType() throws {
        @UserDefault(.test) var test = ""
        
        $test.removeFromDefaults()
        XCTAssertEqual(test, "")
        XCTAssertNil(UserDefaults.standard.value(forKey: $test.key))
        
        test = "test"
        XCTAssertEqual(test, "test")
        XCTAssertEqual(UserDefaults.standard.value(forKey: $test.key) as? String, "test")
        
        $test.removeFromDefaults()
        XCTAssertEqual(test, "")
        XCTAssertNil(UserDefaults.standard.value(forKey: $test.key))
    }
    
    func testArray() throws {
        @UserDefault(.testArray) var testArray = ["a", "b"]
        
        $testArray.removeFromDefaults()
        XCTAssertEqual(testArray, ["a", "b"])
        XCTAssertNil(UserDefaults.standard.value(forKey: $testArray.key))
        
        testArray = ["a", "b", "c"]
        XCTAssertEqual(testArray, ["a", "b", "c"])
        XCTAssertEqual(UserDefaults.standard.value(forKey: $testArray.key) as? Array, ["a", "b", "c"])
        
        $testArray.removeFromDefaults()
        XCTAssertEqual(testArray, ["a", "b"])
        XCTAssertNil(UserDefaults.standard.value(forKey: $testArray.key))
    }
    
    func testDictionary() throws {
        @UserDefault(.testDictionary) var testDictionary = ["a": 1, "b": 2]
        
        $testDictionary.removeFromDefaults()
        XCTAssertEqual(testDictionary, ["a": 1, "b": 2])
        XCTAssertNil(UserDefaults.standard.value(forKey: $testDictionary.key))
        
        testDictionary = ["a": 1, "b": 2, "c": 3]
        XCTAssertEqual(testDictionary, ["a": 1, "b": 2, "c": 3])
        XCTAssertEqual(UserDefaults.standard.value(forKey: $testDictionary.key) as? Dictionary, ["a": 1, "b": 2, "c": 3])
        
        $testDictionary.removeFromDefaults()
        XCTAssertEqual(testDictionary, ["a": 1, "b": 2])
        XCTAssertNil(UserDefaults.standard.value(forKey: $testDictionary.key))
    }
    
    func testOptional() throws {
        @UserDefault(.testOptional) var testOptional: String? = nil
        
        $testOptional.removeFromDefaults()
        XCTAssertNil(testOptional)
        XCTAssertNil(UserDefaults.standard.value(forKey: $testOptional.key))
        
        testOptional = "test"
        XCTAssertEqual(testOptional, Optional<String>("test"))
        XCTAssertEqual(UserDefaults.standard.value(forKey: $testOptional.key) as? String, "test")
        
        testOptional = nil
        XCTAssertNil(testOptional)
        XCTAssertNil(UserDefaults.standard.value(forKey: $testOptional.key))
    }
    
    func testCodable() throws {
        @UserDefault(.testCodable) var testCodabel = CustomType(string: "", int: 0)
        
        $testCodabel.removeFromDefaults()
        XCTAssertEqual(testCodabel, CustomType(string: "", int: 0))
        XCTAssertNil(UserDefaults.standard.value(forKey: $testCodabel.key))
        
        testCodabel = CustomType(string: "a", int: 1)
        XCTAssertEqual(testCodabel, CustomType(string: "a", int: 1))
        let testCodableData = try XCTUnwrap(UserDefaults.standard.value(forKey: $testCodabel.key) as? Data)
        let decodedTestCodableData = try PropertyListDecoder().decode(CustomType.self, from: testCodableData)
        XCTAssertEqual(decodedTestCodableData, CustomType(string: "a", int: 1))
        
        $testCodabel.removeFromDefaults()
        XCTAssertEqual(testCodabel, CustomType(string: "", int: 0))
        XCTAssertNil(UserDefaults.standard.value(forKey: $testCodabel.key))
    }
    
    func testRawRepresentable() throws {
        @UserDefault(.testEnum) var testEnum: RawRepresentableEnumeration = .a
        
        $testEnum.removeFromDefaults()
        XCTAssertEqual(testEnum, .a)
        XCTAssertNil(UserDefaults.standard.value(forKey: $testEnum.key))
        
        testEnum = .b
        XCTAssertEqual(testEnum, .b)
        XCTAssertEqual(UserDefaults.standard.value(forKey: $testEnum.key) as? String, "b")
        
        $testEnum.removeFromDefaults()
        XCTAssertEqual(testEnum, .a)
        XCTAssertNil(UserDefaults.standard.value(forKey: $testEnum.key))
    }
}
