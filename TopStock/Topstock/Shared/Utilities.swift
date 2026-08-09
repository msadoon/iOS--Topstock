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
    
    static private func isWeekday(for date: Date) -> Bool {
        guard let weekdayNumber = Utilities.utcCalendar.dateComponents([.weekday],
                                                                       from: date).weekday else {
            return false
        }
        
        return ![1,7].contains(weekdayNumber)
    }
    
    static func lastWeekDay(from date: Date) -> String {
        guard var yesterdaysDate = Utilities.utcCalendar.date(byAdding: .day, value: -1, to: date, wrappingComponents: false) else {
            return ""
        }
        
        if !isWeekday(for: yesterdaysDate) {
            repeat {
                if let anotherPossibleWeekday = Utilities.utcCalendar.date(byAdding: .day, value: -1, to: yesterdaysDate, wrappingComponents: false) {
                    yesterdaysDate = anotherPossibleWeekday
                }
            } while !isWeekday(for: yesterdaysDate)
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
    
    static func formattedTime(for date: Date?) -> [Int: Int] {
        guard let dateValue = date else {
            return [:]
        }
        
        let hourAndMinute = Utilities.utcCalendar.dateComponents([.hour, .minute], from: dateValue)
        
        guard let hour = hourAndMinute.hour,
              let minute = hourAndMinute.minute else {
            return [:]
        }
        
        return [hour: minute]
    }
}
