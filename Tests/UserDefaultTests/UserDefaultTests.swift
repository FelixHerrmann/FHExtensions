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
    static let valueType: UserDefaultKey = "com.felixherrmann.FHExtensions.valueType"
    static let array: UserDefaultKey = "com.felixherrmann.FHExtensions.array"
    static let dictionary: UserDefaultKey = "com.felixherrmann.FHExtensions.dictionary"
    static let optional: UserDefaultKey = "com.felixherrmann.FHExtensions.optional"
    static let codable: UserDefaultKey = "com.felixherrmann.FHExtensions.codable"
    static let rawRepresentable: UserDefaultKey = "com.felixherrmann.FHExtensions.rawRepresentable"
}

final class UserDefaultTests: XCTestCase {
    
    @UserDefault(.valueType) var valueType = ""
    @UserDefault(.array) var array = ["a", "b"]
    @UserDefault(.dictionary) var dictionary = ["a": 1, "b": 2]
    @UserDefault(.optional) var optional: String? = nil
    @UserDefault(.codable) var codabel = CustomType(string: "", int: 0)
    @UserDefault(.rawRepresentable) var rawRepresentable: RawRepresentableEnumeration = .a
    
    func testValueType() throws {
        $valueType.removeFromDefaults()
        XCTAssertEqual(valueType, "")
        XCTAssertNil(UserDefaults.standard.value(forKey: $valueType.key))
        
        valueType = "test"
        XCTAssertEqual(valueType, "test")
        XCTAssertEqual(UserDefaults.standard.value(forKey: $valueType.key) as? String, "test")
        
        $valueType.removeFromDefaults()
        XCTAssertEqual(valueType, "")
        XCTAssertNil(UserDefaults.standard.value(forKey: $valueType.key))
    }
    
    func testArray() throws {
        $array.removeFromDefaults()
        XCTAssertEqual(array, ["a", "b"])
        XCTAssertNil(UserDefaults.standard.value(forKey: $array.key))
        
        array = ["a", "b", "c"]
        XCTAssertEqual(array, ["a", "b", "c"])
        XCTAssertEqual(UserDefaults.standard.value(forKey: $array.key) as? Array, ["a", "b", "c"])
        
        $array.removeFromDefaults()
        XCTAssertEqual(array, ["a", "b"])
        XCTAssertNil(UserDefaults.standard.value(forKey: $array.key))
    }
    
    func _testDictionary() throws {
        $dictionary.removeFromDefaults()
        XCTAssertEqual(dictionary, ["a": 1, "b": 2])
        XCTAssertNil(UserDefaults.standard.value(forKey: $dictionary.key))
        
        dictionary = ["a": 1, "b": 2, "c": 3]
        XCTAssertEqual(dictionary, ["a": 1, "b": 2, "c": 3])
        XCTAssertEqual(UserDefaults.standard.value(forKey: $dictionary.key) as? Dictionary, ["a": 1, "b": 2, "c": 3])
        
        $dictionary.removeFromDefaults()
        XCTAssertEqual(dictionary, ["a": 1, "b": 2])
        XCTAssertNil(UserDefaults.standard.value(forKey: $dictionary.key))
    }
    
    func testOptional() throws {
        $optional.removeFromDefaults()
        XCTAssertNil(optional)
        XCTAssertNil(UserDefaults.standard.value(forKey: $optional.key))
        
        optional = "test"
        XCTAssertEqual(optional, Optional<String>("test"))
        XCTAssertEqual(UserDefaults.standard.value(forKey: $optional.key) as? String, "test")
        
        optional = nil
        XCTAssertNil(optional)
        XCTAssertNil(UserDefaults.standard.value(forKey: $optional.key))
    }
    
    func testCodable() throws {
        $codabel.removeFromDefaults()
        XCTAssertEqual(codabel, CustomType(string: "", int: 0))
        XCTAssertNil(UserDefaults.standard.value(forKey: $codabel.key))
        
        codabel = CustomType(string: "a", int: 1)
        XCTAssertEqual(codabel, CustomType(string: "a", int: 1))
        let testCodableData = try XCTUnwrap(UserDefaults.standard.value(forKey: $codabel.key) as? Data)
        let decodedTestCodableData = try PropertyListDecoder().decode(CustomType.self, from: testCodableData)
        XCTAssertEqual(decodedTestCodableData, CustomType(string: "a", int: 1))
        
        $codabel.removeFromDefaults()
        XCTAssertEqual(codabel, CustomType(string: "", int: 0))
        XCTAssertNil(UserDefaults.standard.value(forKey: $codabel.key))
    }
    
    func testRawRepresentable() throws {
        $rawRepresentable.removeFromDefaults()
        XCTAssertEqual(rawRepresentable, .a)
        XCTAssertNil(UserDefaults.standard.value(forKey: $rawRepresentable.key))
        
        rawRepresentable = .b
        XCTAssertEqual(rawRepresentable, .b)
        XCTAssertEqual(UserDefaults.standard.value(forKey: $rawRepresentable.key) as? String, "b")
        
        $rawRepresentable.removeFromDefaults()
        XCTAssertEqual(rawRepresentable, .a)
        XCTAssertNil(UserDefaults.standard.value(forKey: $rawRepresentable.key))
    }
}
