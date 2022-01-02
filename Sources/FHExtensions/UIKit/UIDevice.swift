#if canImport(UIKit)
import UIKit

extension UIDevice {
    
    /// Returns the model identifier of the current device.
    public var modelIdentifier: String {
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
            return simulatorModelIdentifier
        }
        
        var len = 0
        sysctlbyname("hw.model", nil, &len, nil, 0)
        var modelPointer: CChar = CChar(len * MemoryLayout.size(ofValue: Character.self))
        sysctlbyname("hw.model", &modelPointer, &len, nil, 0)
        let model = String(cString: &modelPointer)
        
        if model.lowercased().contains("mac") {
            return model
        } else {
            var systemInfo = utsname()
            uname(&systemInfo)
            return String(decoding: Data(bytes: &systemInfo.machine, count: Int(_SYS_NAMELEN)), as: UTF8.self)
                .trimmingCharacters(in: .controlCharacters)
        }
    }
}

#endif // canImport(UIKit)
