import Foundation

extension JSONEncoder.DateEncodingStrategy {
    
    /// The strategy that formats dates according to the ISO 8601 and RFC 3339 standards with fractional seconds.
    @available(OSX 10.13, iOS 11.0, tvOS 11.0, *)
    public static let iso8601withFractionalSeconds = custom { date, encoder in
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFractionalSeconds, .withInternetDateTime]
        let dateString = formatter.string(from: date)
        var container = encoder.singleValueContainer()
        try container.encode(dateString)
    }
}
