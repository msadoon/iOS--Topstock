import Foundation

struct GlobalVars {
    
    /// MARK: Text formatting
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
        
        enum TimeLine: String {
            static let timePeriod = "Time Period"
            case fiveMinPeriod = "5 Minutes"
            case oneHourPeriod = "1 Hour"
        }
    }
    
    public struct HistoricalBars {
        public enum AxisTitles: String {
            case timeFrame = "Timeframe"
            case value = "USD"
        }
    }
    
    /// MARK: Number formatting
    enum Formatting: Int {
        case numberPrecision = 2
    }
    
    enum TimeZone: String {
        case UTC
    }
    
    /// MARK: Image formatting
    enum ImageSymbols: String {
        case placeholder = "photo.fill"
        case market = "chart.bar.xaxis"
        case gainers = "chart.line.uptrend.xyaxis"
        case losers = "chart.line.downtrend.xyaxis"
    }
    
    enum ImageStyling: CGFloat {
        case cornerRadius = 10.0
        case relativeWidthOneFifth = 0.2
        case relativeWidthTwoThirds = 0.67
    }
    
    public enum Corners: CGFloat {
        case largeRadius = 20.0
        case smallRadius = 5.0
    }
    
    public enum Shadow: CGFloat {
        case smallRadius = 5.0
        case largeRadius = 10.0
    }
}
