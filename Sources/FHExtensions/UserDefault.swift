import Foundation
import os.log


// MARK: - UserDefaultStorable

/// Add the capability to store the object inside the **UserDefaults**.
public protocol UserDefaultStorable {
    
    /// Store the value inside the `store`.
    static func store(value: Self, in store: UserDefaults, key: UserDefaultKey) throws
    
    /// Get the value from the `store`.
    static func read(in store: UserDefaults, key: UserDefaultKey) throws -> Self?
}

extension UserDefaultStorable {
    
    /// A convenience method which can be called on the instance directly.
    public func store(in store: UserDefaults, key: UserDefaultKey) throws {
        try Self.store(value: self, in: store, key: key)
    }
}


// MARK: - UserDefaultKey

public typealias UserDefaultKey = String


// MARK: - UserDefault

/// A property wrapper which reads and writes the wrapped value in the **UserDefaults** store.
///
/// The wrapped value must conform to **UserDefaultStorable**.
@propertyWrapper public struct UserDefault<Value: UserDefaultStorable>  {
    
    /// The default value if a value of the given type is not specified for the given key.
    public let defaultValue: Value
    
    /// The key to read and write the value to in the **UserDefaults** store.
    public let key: UserDefaultKey
    
    /// The **UserDefaults** store to read and write to.
    public let store: UserDefaults
    
    /// Creates a property that can read and write to a user default from the give type.
    /// - Parameters:
    ///   - defaultValue: The default value if a value of the given type is not specified for the given key.
    ///   - key: The key to read and write the value to in the **UserDefaults** store.
    ///   - store: The **UserDefaults** store to read and write to. Default value is `UserDefaults.standard`.
    public init(wrappedValue defaultValue: Value, _ key: UserDefaultKey, store: UserDefaults = .standard) {
        self.defaultValue = defaultValue
        self.key = key
        self.store = store
    }
    
    public var wrappedValue: Value {
        get {
            do {
                return try Value.read(in: store, key: key) ?? defaultValue
            } catch {
                if #available(OSX 10.12, iOS 10.0, tvOS 10.0, *) {
                    os_log("Error: %@", log: OSLog(subsystem: "com.felixherrmann.FHExtensions", category: "CodableUserDefault"), type: .error, String(describing: error))
                } else {
                    NSLog("Error: %@", String(describing: error))
                }
                return defaultValue
            }
        }
        set {
            do {
                try newValue.store(in: store, key: key)
            } catch {
                if #available(OSX 10.12, iOS 10.0, tvOS 10.0, *) {
                    os_log("Error: %@", log: OSLog(subsystem: "com.felixherrmann.FHExtensions", category: "CodableUserDefault"), type: .error, String(describing: error))
                } else {
                    NSLog("Error: %@", String(describing: error))
                }
            }
        }
    }
    
    public var projectedValue: UserDefault {
        return self
    }
    
    /// Remove the stored value from UserDefaults.
    ///
    /// To access this method you have to access the property wrapper via the projected value.
    /// ```swift
    /// @UserDefault("test", defaultValue: "") var test: String
    /// $test.removeFromDefaults()
    /// ```
    public func removeFromDefaults() {
        store.removeObject(forKey: key)
    }
}


// MARK: - UserDefaultStorable + Bool

extension Bool: UserDefaultStorable {
    
    public static func store(value: Bool, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value, forKey: key)
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> Bool? {
        return store.value(forKey: key) as? Bool
    }
}

// MARK: - UserDefaultStorable + NSNumber

extension NSNumber: UserDefaultStorable {
    
    public static func store(value: NSNumber, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value, forKey: key)
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> Self? {
        return store.value(forKey: key) as? Self
    }
}


// MARK: - UserDefaultStorable + Int

extension Int: UserDefaultStorable {
    
    public static func store(value: Int, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value, forKey: key)
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> Int? {
        return store.value(forKey: key) as? Int
    }
}


// MARK: - UserDefaultStorable + Int8

extension Int8: UserDefaultStorable {
    
    public static func store(value: Int8, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value, forKey: key)
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> Int8? {
        return store.value(forKey: key) as? Int8
    }
}


// MARK: - UserDefaultStorable + Int16

extension Int16: UserDefaultStorable {
    
    public static func store(value: Int16, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value, forKey: key)
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> Int16? {
        return store.value(forKey: key) as? Int16
    }
}


// MARK: - UserDefaultStorable + Int32

extension Int32: UserDefaultStorable {
    
    public static func store(value: Int32, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value, forKey: key)
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> Int32? {
        return store.value(forKey: key) as? Int32
    }
}


// MARK: - UserDefaultStorable + Int64

extension Int64: UserDefaultStorable {
    
    public static func store(value: Int64, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value, forKey: key)
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> Int64? {
        return store.value(forKey: key) as? Int64
    }
}


// MARK: - UserDefaultStorable + UInt

extension UInt: UserDefaultStorable {
    
    public static func store(value: UInt, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value, forKey: key)
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> UInt? {
        return store.value(forKey: key) as? UInt
    }
}


// MARK: - UserDefaultStorable + UInt8

extension UInt8: UserDefaultStorable {
    
    public static func store(value: UInt8, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value, forKey: key)
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> UInt8? {
        return store.value(forKey: key) as? UInt8
    }
}


// MARK: - UserDefaultStorable + UInt16

extension UInt16: UserDefaultStorable {
    
    public static func store(value: UInt16, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value, forKey: key)
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> UInt16? {
        return store.value(forKey: key) as? UInt16
    }
}


// MARK: - UserDefaultStorable + UInt32

extension UInt32: UserDefaultStorable {
    
    public static func store(value: UInt32, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value, forKey: key)
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> UInt32? {
        return store.value(forKey: key) as? UInt32
    }
}


// MARK: - UserDefaultStorable + UInt64

extension UInt64: UserDefaultStorable {
    
    public static func store(value: UInt64, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value, forKey: key)
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> UInt64? {
        return store.value(forKey: key) as? UInt64
    }
}


// MARK: - UserDefaultStorable + Float

extension Float: UserDefaultStorable {
    
    public static func store(value: Float, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value, forKey: key)
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> Float? {
        return store.value(forKey: key) as? Float
    }
}


#if os(macOS) && arch(x86_64)
// MARK: - UserDefaultStorable + Float80

extension Float80: UserDefaultStorable {
    
    public static func store(value: Float80, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value, forKey: key._value)
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> Float80? {
        return store.value(forKey: key._value) as? Float80
    }
}
#endif


// MARK: - UserDefaultStorable + Double

extension Double: UserDefaultStorable {
    
    public static func store(value: Double, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value, forKey: key)
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> Double? {
        return store.value(forKey: key) as? Double
    }
}


// MARK: - UserDefaultStorable + NSString

extension NSString: UserDefaultStorable {
    
    public static func store(value: NSString, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value, forKey: key)
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> Self? {
        return store.value(forKey: key) as? Self
    }
}


// MARK: - UserDefaultStorable + String

extension String: UserDefaultStorable {
    
    public static func store(value: String, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value, forKey: key)
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> String? {
        return store.value(forKey: key) as? String
    }
}


// MARK: - UserDefaultStorable + NSDate

extension NSDate: UserDefaultStorable {
    
    public static func store(value: NSDate, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value, forKey: key)
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> Self? {
        return store.value(forKey: key) as? Self
    }
}


// MARK: - UserDefaultStorable + Date

extension Date: UserDefaultStorable {
    
    public static func store(value: Date, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value, forKey: key)
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> Date? {
        return store.value(forKey: key) as? Date
    }
}


// MARK: - UserDefaultStorable + NSURL

extension NSURL: UserDefaultStorable {
    
    public static func store(value: NSURL, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value, forKey: key)
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> Self? {
        return store.value(forKey: key) as? Self
    }
}


// MARK: - UserDefaultStorable + URL

extension URL: UserDefaultStorable {
    
    public static func store(value: URL, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value, forKey: key)
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> URL? {
        return store.value(forKey: key) as? URL
    }
}


// MARK: - UserDefaultStorable + NSData

extension NSData: UserDefaultStorable {
    
    public static func store(value: NSData, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value, forKey: key)
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> Self? {
        return store.value(forKey: key) as? Self
    }
}


// MARK: - UserDefaultStorable + Data

extension Data: UserDefaultStorable {
    
    public static func store(value: Data, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value, forKey: key)
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> Data? {
        return store.value(forKey: key) as? Data
    }
}


// MARK: - UserDefaultStorable + Array

extension Array: UserDefaultStorable where Element: UserDefaultStorable {
    
    public static func store(value: Array, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value, forKey: key)
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> Array? {
        return store.value(forKey: key) as? Array
    }
}


// MARK: - UserDefaultStorable + Dictionary

extension Dictionary: UserDefaultStorable where Key: UserDefaultStorable, Value: UserDefaultStorable {
    
    public static func store(value: Dictionary, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value, forKey: key)
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> Dictionary? {
        return store.value(forKey: key) as? Dictionary
    }
}


// MARK: - UserDefaultStorable + Optional

extension Optional: UserDefaultStorable where Wrapped: UserDefaultStorable {
    
    public static func store(value: Optional<Wrapped>, in store: UserDefaults, key: UserDefaultKey) throws {
        switch value {
        case .some(let storable):
            try storable.store(in: store, key: key)
        case .none:
            store.removeObject(forKey: key)
        }
    }
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> Optional<Wrapped>? {
        return store.value(forKey: key) as? Optional<Wrapped>
    }
}


// MARK: - UserDefaultStorable + Codable implementation

extension Encodable where Self: UserDefaultStorable {
    
    public static func store(value: Self, in store: UserDefaults, key: UserDefaultKey) throws {
        let encoder = PropertyListEncoder()
        let data = try encoder.encode(value)
        store.set(data, forKey: key)
    }
}

extension Decodable where Self: UserDefaultStorable {
    
    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> Self? {
        guard let data = store.value(forKey: key) as? Data else { return nil }
        let decoder = PropertyListDecoder()
        return try decoder.decode(Self.self, from: data)
    }
}


// MARK: - UserDefaultStorable + RawRepresentable implementation

extension RawRepresentable where RawValue: UserDefaultStorable {

    public static func store(value: Self, in store: UserDefaults, key: UserDefaultKey) throws {
        store.set(value.rawValue, forKey: key)
    }

    public static func read(in store: UserDefaults, key: UserDefaultKey) throws -> Self? {
        guard let rawValue = store.value(forKey: key) as? RawValue else { return nil }
        return Self(rawValue: rawValue)
    }
}
