import Foundation

public extension Date {
    
    /// Initialize a `Date` by date components.
    ///
    /// Can fail if a date could not be found which matches the components.
    /// - Parameters:
    ///   - day: The day of the date.
    ///   - month: The month of the date.
    ///   - year: The year of the date.
    ///   - hour: The hour of the date. Default is nil.
    ///   - minute: The minute of the date. Default is nil.
    ///   - second: The second of the date. Default is nil.
    init?(_ day: Int, _ month: Int, _ year: Int, hour: Int? = nil, minute: Int? = nil, second: Int? = nil) {
        let dateComponents = DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        guard let date = Calendar.current.date(from: dateComponents) else {
            return nil
        }
        
        self = date
    }
}
