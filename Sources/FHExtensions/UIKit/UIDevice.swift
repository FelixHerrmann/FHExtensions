#if canImport(UIKit)
import UIKit

extension UIDevice {
    
    /// Returns the model identifier of the current device.
    public var modelIdentifier: String {
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
            return simulatorModelIdentifier
        }
        #if targetEnvironment(macCatalyst)
        var len = 0
        sysctlbyname("hw.model", nil, &len, nil, 0)
        var model: CChar = CChar(len * MemoryLayout.size(ofValue: Character.self))
        sysctlbyname("hw.model", &model, &len, nil, 0)
        return String(cString: &model)
        #else
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        return machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        #endif
    }
}

#endif // canImport(UIKit)
