import Foundation

struct Utilities {
    static private var utcDateFormatter: ISO8601DateFormatter {
        let utcDateFormatter = ISO8601DateFormatter()
        utcDateFormatter.timeZone = TimeZone(abbreviation: GlobalVars.TimeZone.UTC.rawValue) ?? .gmt
        
        return utcDateFormatter
    }
    
    static func validUTCDate(from dateRawValue: String) -> Bool {
        guard let _ = Utilities.utcDateFormatter.date(from: dateRawValue) else {
            return false
        }
        
        return true
    }
}
