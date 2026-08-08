enum TopStockAPIEndpoint {
    static let baseEndpoint = "https://api.topstockdev.ca"
    
    enum HistoricalBarTimeFrame: String {
        case FiveMin = "5Min"
        case OneHour = "1H"
    }
    
    case moversStocks
    case historicalBars(String, HistoricalBarTimeFrame, String)
    case logos(String)
    
    var validPathComponentDescription: String? {
        switch self {
        case .moversStocks:
            return "movers/stocks"
        case .historicalBars(let symbol,
                             _,
                             _):
            return "stocks/\(symbol)"
        case .logos(let symbol):
            return "logos/\(symbol)"
        }
    }
    
    var queryItems: [String: String] {
        switch self {
        case .historicalBars(_,
                             let timeFrame,
                             let datetime):
            guard let _ = Utilities.validUTCDate(from: datetime) else {
                return [:]
            }
            
            return ["timeframe": timeFrame.rawValue,
                    "date": datetime]
        case .moversStocks,
             .logos:
            return [:]
        }
    }
}

protocol TopStockAPI: Sendable {
    func retrieveData<T: Decodable>(for: TopStockAPIEndpoint) async throws -> T
}
