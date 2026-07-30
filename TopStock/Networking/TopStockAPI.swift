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
                             let timeFrame,
                             let datetime):
            guard let _ = Utilities.validUTCDate(from: datetime) else {
                return nil
            }
            
            return "stocks/\(symbol)?timeframe=\(timeFrame.rawValue)&date=\(datetime)"
        case .logos(let symbol):
            return "logos/\(symbol)"
        }
    }
}

protocol TopStockAPI: Sendable {
    func retrieveData<T: Decodable>(for: TopStockAPIEndpoint) async throws -> T
}
