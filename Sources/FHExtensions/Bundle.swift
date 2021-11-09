import Foundation

extension Bundle {
    
    /// The `CFBundleShortVersionString` value in the `Bundle.infoDictionary`.
    /// This represents the version number of the bundle.
    public var versionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    /// The `CFBundleVersion` value in the `Bundle.infoDictionary`.
    /// This represents the build number of the bundle.
    public var buildNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
