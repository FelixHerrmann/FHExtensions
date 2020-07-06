import Foundation
import os.log

/// All types allowed in the `UserDefaults`.
///
/// # Allowed types are:
/// * `Bool`
/// * `Int`
/// * `Float`
/// * `Double`
/// * `String`
/// * `Date`
/// * `URL`
/// * `Data`
/// * `Array<UserDefaultType>`
/// * `Dictionary<UserDefaultType, UserDefaultType>`
public protocol UserDefaultType { }

extension Bool: UserDefaultType { }
extension Int: UserDefaultType { }
extension Float: UserDefaultType { }
extension Double: UserDefaultType { }
extension String: UserDefaultType { }
extension Date: UserDefaultType { }
extension URL: UserDefaultType { }
extension Data: UserDefaultType { }
extension Array: UserDefaultType where Element: UserDefaultType { }
extension Dictionary: UserDefaultType where Key: UserDefaultType, Value: UserDefaultType { }

/// Property Wrapper which stores the wrapped value in the `UserDefaults`.
///
/// The wrapped value must be of type `UserDefaultType`.
/// For every other type use the `CodableUserDefault` wrapper.
@propertyWrapper
public struct UserDefault<T: UserDefaultType> {
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
}

/// Property Wrapper which stores the wrapped value in the `UserDefaults`.
///
/// The wrapped value must be of type `Codable`.
@propertyWrapper
public struct CodableUserDefault<T: Codable> {
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
                if #available(OSX 10.12, *) {
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
                if #available(OSX 10.12, *) {
                    os_log("Error: %@", log: OSLog(subsystem: "com.felixherrmann.FHExtensions", category: "CodableUserDefault"), type: .error, String(describing: error))
                } else {
                    NSLog("Error: %@", String(describing: error))
                }
            }
        }
    }
}
