import Foundation

struct Utilities {
    static private var utcDateFormatter: ISO8601DateFormatter {
        let utcDateFormatter = ISO8601DateFormatter()
        utcDateFormatter.timeZone = TimeZone(abbreviation: GlobalVars.TimeZone.UTC.rawValue) ?? .gmt
        
        return utcDateFormatter
    }
    
    static func validUTCDate(from dateRawValue: String) -> Date? {
        guard let date = Utilities.utcDateFormatter.date(from: dateRawValue) else {
            return nil
        }
        
        return date
    }
    
    static func formattedDollarChange(for security: Security) -> String {
        String(format: GlobalVars.Text.dollarChange.rawValue, security.change
                .formatted(.number
                    .precision(.fractionLength(GlobalVars.Formatting.numberPrecision.rawValue))))
    }
    
    static func formattedPercentChange(for security: Security) -> String {
        String(format: GlobalVars.Text.percentChange.rawValue, Int(security.percentChange))
    }
}
