import Foundation
import os.log

/// All types allowed in the `UserDefaults`.
///
/// # Allowed types are:
/// * `NSNumber`
/// * `Bool`
/// * `Int`, `Int8`, `Int16`, `Int32`, `Int64`
/// * `UInt`, `UInt8`, `UInt16`, `UInt32`, `UInt64`
/// * `Float`, `Double`, `Float80`
/// * `String`, `NSString`
/// * `Date`, `NSDate`
/// * `URL`, `NSURL`
/// * `Data`, `NSData`
/// * `Array<UserDefaultType>`
/// * `Dictionary<UserDefaultType, UserDefaultType>`
public protocol UserDefaultType { }

extension NSNumber: UserDefaultType { }
extension Bool: UserDefaultType { }
extension Int: UserDefaultType { }
extension Int8: UserDefaultType { }
extension Int16: UserDefaultType { }
extension Int32: UserDefaultType { }
extension Int64: UserDefaultType { }
extension UInt: UserDefaultType { }
extension UInt8: UserDefaultType { }
extension UInt16: UserDefaultType { }
extension UInt32: UserDefaultType { }
extension UInt64: UserDefaultType { }
extension Float: UserDefaultType { }
extension Double: UserDefaultType { }
extension NSString: UserDefaultType { }
extension String: UserDefaultType { }
extension NSDate: UserDefaultType { }
extension Date: UserDefaultType { }
extension NSURL: UserDefaultType { }
extension URL: UserDefaultType { }
extension NSData: UserDefaultType { }
extension Data: UserDefaultType { }
extension Array: UserDefaultType where Element: UserDefaultType { }
extension Dictionary: UserDefaultType where Key: UserDefaultType, Value: UserDefaultType { }

#if os(macOS) && arch(x86_64)
extension Float80: UserDefaultType { }
#endif

/// Property Wrapper which stores the wrapped value in the `UserDefaults`.
///
/// The wrapped value must be of type `UserDefaultType`.
/// For every other type use the `CodableUserDefault` wrapper.
@propertyWrapper public struct UserDefault<T> where T: UserDefaultType {
    public let key: String
    public let defaultValue: T
    
    public init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T {
        get {
            return UserDefaults.standard.value(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
    /// Remove the stored value from UserDefaults.
    ///
    /// To access this method you have to access the property wrapper with an underscore.
    /// ```swift
    /// @UserDefault("test", defaultValue: "") var test: String
    /// _test.removeFromDefaults()
    /// ```
    public func removeFromDefaults() {
        UserDefaults.standard.set(nil, forKey: key)
    }
}

/// Property Wrapper which stores the wrapped value in the `UserDefaults`.
///
/// The wrapped value must be of type `Optional<UserDefaultType>`.
/// For every other type use the `CodableUserDefault` wrapper.
@propertyWrapper public struct OptionalUserDefault<T> where T: UserDefaultType {
    public let key: String
    
    public init(_ key: String) {
        self.key = key
    }
    
    public var wrappedValue: T? {
        get {
            return UserDefaults.standard.value(forKey: key) as? T
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

/// Property Wrapper which stores the wrapped value in the `UserDefaults`.
///
/// The wrapped value must be of type `Codable`.
@propertyWrapper public struct CodableUserDefault<T> where T: Codable {
    public let key: String
    public let defaultValue: T
    
    public init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.value(forKey: key) as? Data else { return defaultValue }
            
            do {
                let value = try PropertyListDecoder().decode(T.self, from: data)
                return value
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
                UserDefaults.standard.set(try PropertyListEncoder().encode(newValue), forKey: key)
            } catch {
                if #available(OSX 10.12, iOS 10.0, tvOS 10.0, *) {
                    os_log("Error: %@", log: OSLog(subsystem: "com.felixherrmann.FHExtensions", category: "CodableUserDefault"), type: .error, String(describing: error))
                } else {
                    NSLog("Error: %@", String(describing: error))
                }
            }
        }
    }
    
    /// Remove the stored value from UserDefaults.
    ///
    /// To access this method you have to access the property wrapper with an underscore.
    /// ```swift
    /// @UserDefault("test", defaultValue: "") var test: String
    /// _test.removeFromDefaults()
    /// ```
    public func removeFromDefaults() {
        UserDefaults.standard.set(nil, forKey: key)
    }
}
