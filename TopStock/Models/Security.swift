import Foundation

enum Exchange: String {
    case NYSE
    case NASDAQ
    case AMEX
    case unknown
}

enum SnapshotPeriod: String, CaseIterable {
    case sevenDay = "7_day"
    case sixMonth = "6_month"
    case oneYear = "1_year"
    
    var description: String {
        switch self {
        case .sevenDay:
            GlobalVars.Text.Exchange.sevenDayPeriod.rawValue
        case .sixMonth:
            GlobalVars.Text.Exchange.sixMonthDayPeriod.rawValue
        case .oneYear:
            GlobalVars.Text.Exchange.oneYearPeriod.rawValue
        }
    }
}

struct Security: Decodable, Hashable, Identifiable {
    let id: String
    let ticker: String
    let name: String
    let dateAdded: Date?
    let exchange: Exchange
    let snapshots: [SnapshotPeriod: URL]
    
    enum CodingKeys: CodingKey {
        case id
        case ticker
        case name
        case exchange
        case marketSnapshots
        case dateAdded
    }
    
    enum SnapshotKeys: String {
        case period
        case url
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.ticker = try container.decode(String.self, forKey: .ticker)
        
        let isoDateFormatter = ISO8601DateFormatter()
        let dateRawValue = try container.decode(String.self, forKey: .dateAdded)
        isoDateFormatter.formatOptions =  [.withInternetDateTime, .withFractionalSeconds]
        self.dateAdded = isoDateFormatter.date(from: dateRawValue)
        
        let exchangeRawValue = try container.decode(String.self, forKey: .exchange)
        
        self.exchange = Exchange(rawValue: exchangeRawValue) ?? .unknown
        
        let periodImages = try container.decode([[String: String]].self, forKey: .marketSnapshots)
        
        var availableSnapshots = [SnapshotPeriod: URL]()
        
        for periodImage in periodImages {
            if let periodRawValue = periodImage[SnapshotKeys.period.rawValue],
               let imageRawValue = periodImage[SnapshotKeys.url.rawValue],
               let period = SnapshotPeriod(rawValue: periodRawValue),
               let url = URL(string: imageRawValue) {
                availableSnapshots[period] = url
            }
        }
        
        self.snapshots = availableSnapshots
    }
}

