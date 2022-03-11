import Foundation

extension JSONDecoder.DateDecodingStrategy {
    
    /// The strategy that formats dates according to the ISO 8601 standard with fractional seconds.
    @available(macOS 10.13, iOS 11.0, tvOS 11.0, *)
    public static let iso8601withFractionalSeconds = custom { decoder -> Date in
        let container = try decoder.singleValueContainer()
        let dateString = try container.decode(String.self)
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFractionalSeconds, .withInternetDateTime]
        if let date = formatter.date(from: dateString) {
            return date
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: " + dateString)
        }
    }
}
