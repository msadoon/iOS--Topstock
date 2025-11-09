import Foundation

struct GlobalVars {
    enum Brand: String {
        case title = "TopStock"
    }
    
    enum Text: String {
        case numAccounts = "# Accounts: "
        case advisors = "Advisors"
        case accounts = "Accounts"
        case accountNum = "Account #"
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
        case filter = "line.3.horizontal.decrease.circle"
        case custodian = "folder.fill"
    }
    
    enum ImageStyling: CGFloat {
        case cornerRadius = 10.0
        case relativeWidthOneFifth = 0.2
        case relativeWidthTwoThirds = 0.67
    }
    
    enum Padding: CGFloat {
        case ten = 10.0
        case hundred = 100.0
    }
}
