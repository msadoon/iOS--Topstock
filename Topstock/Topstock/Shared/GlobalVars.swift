import Foundation

struct GlobalVars {
    enum Brand: String {
        case title = "TopStock"
    }
    
    enum Text: String {
        case dollarChange = "$%@"
        case percentChange = "%i%%"
        case gainers = "Gainers"
        case losers = "Losers"
        case generalError = "Unknown"
        case defaultCurrency = "USD"
        case dateAdded = "Date Added: "
        
        enum Exchange: String {
            case timePeriod = "Time Period"
            case sevenDayPeriod = "7 Day"
            case sixMonthDayPeriod = "6 Month"
            case oneYearPeriod = "1 Year"
        }
    }
    
    enum ImageSymbols: String {
        case placeholder = "person.circle"
        case market = "chart.bar.xaxis"
        case gainers = "chart.line.uptrend.xyaxis"
        case losers = "chart.line.downtrend.xyaxis"
    }
    
    enum ImageStyling: CGFloat {
        case cornerRadius = 10.0
        case relativeWidthOneFifth = 0.2
        case relativeWidthTwoThirds = 0.67
    }
    
    enum Formatting: Int {
        case numberPrecision = 2
    }
    
    enum Padding: CGFloat {
        case ten = 10.0
        case fifty = 100.0
    }
    
    enum TimeZone: String {
        case UTC
    }
}
