import Foundation

struct Utilities {
    static private var utcDateFormatter: ISO8601DateFormatter {
        let utcDateFormatter = ISO8601DateFormatter()
        utcDateFormatter.timeZone = Utilities.utcTimeZone
        
        return utcDateFormatter
    }
    
    static private var utcTimeZone: TimeZone {
        TimeZone(abbreviation: GlobalVars.TimeZone.UTC.rawValue) ?? .gmt
    }
    
    static private var utcCalendar: Calendar {
        var utcCalendar = Calendar.current
        
        utcCalendar.timeZone = Utilities.utcTimeZone
        
        return utcCalendar
    }
    
    /** FIXME:  Testable */
    static func yesterdaysUTCDate() -> String {
        let todaysDate = Date.now
        
        guard let yesterdaysDate = Utilities.utcCalendar.date(byAdding: .day, value: -1, to: todaysDate, wrappingComponents: false) else {
            return ""
        }
        
        return Utilities.utcDateFormatter.string(from: yesterdaysDate)
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
    
    /** FIXME:  Testable */
    static func formattedTime(for date: Date?, timeFrame: TopStockAPIEndpoint.HistoricalBarTimeFrame) -> Int? {
        guard let dateValue = date else {
            return nil
        }
        
        let calendarTimeFrame: Calendar.Component = timeFrame == .FiveMin ? .minute : .hour
        
        let conversionResultDateComponents = Calendar.current.dateComponents([calendarTimeFrame], from: dateValue)

        let formattedTime = timeFrame == .FiveMin ? conversionResultDateComponents.minute : conversionResultDateComponents.hour
        
        return formattedTime
    }
}
