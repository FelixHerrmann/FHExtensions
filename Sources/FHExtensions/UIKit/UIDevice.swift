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
        var modelBuffer = Array<CChar>(repeating: 0, count: len)
        sysctlbyname("hw.model", &modelBuffer, &len, nil, 0)
        let model = String(cString: modelBuffer)
        
        if model.lowercased().contains("mac") {
            return model
        } else {
            var systemInfo = utsname()
            uname(&systemInfo)
            let data = Data(bytes: &systemInfo.machine, count: Int(_SYS_NAMELEN))
            return String(decoding: data, as: UTF8.self)
                .trimmingCharacters(in: .controlCharacters)
        }
    }
}

#endif // canImport(UIKit)
