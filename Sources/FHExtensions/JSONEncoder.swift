import Foundation

@available(OSX 10.13, *)
@available(iOS 11.0, *)
public extension JSONEncoder.DateEncodingStrategy {
    
    /// The strategy that formats dates according to the ISO 8601 and RFC 3339 standards with fractional seconds.
    static let iso8601withFractionalSeconds = custom { (date, encoder) in
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFractionalSeconds, .withInternetDateTime]
        let dateString = formatter.string(from: date)
        var container = encoder.singleValueContainer()
        try container.encode(dateString)
    }
}
