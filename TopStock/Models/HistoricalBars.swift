import Foundation

struct HistoricalBars: Decodable {
    let bars: [CandleStickBar]
    let symbol: String
}

struct CandleStickBar: Decodable {
    let timestamp: Date?
    let openPrice: Float
    let closePrice: Float
    let highPrice: Float
    let lowPrice: Float
    let volume: Int
    let numTrades: Int
    let volumeWeightedAveragePrice: Float
    
    enum CodingKeys: String, CodingKey {
        case timestamp = "t"
        case openPrice = "o"
        case closePrice = "c"
        case highPrice = "h"
        case lowPrice = "l"
        case volume = "v"
        case numTrades = "n"
        case volumeWeightedAveragePrice = "vw"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let rawDateValue = try container.decode(String.self, forKey: .timestamp)
        self.timestamp = Utilities.validUTCDate(from: rawDateValue)
        self.openPrice = try container.decode(Float.self, forKey: .openPrice)
        self.closePrice = try container.decode(Float.self, forKey: .closePrice)
        self.highPrice = try container.decode(Float.self, forKey: .highPrice)
        self.lowPrice = try container.decode(Float.self, forKey: .lowPrice)
        self.volume = try container.decode(Int.self, forKey: .volume)
        self.numTrades = try container.decode(Int.self, forKey: .numTrades)
        self.volumeWeightedAveragePrice = try container.decode(Float.self, forKey: .volumeWeightedAveragePrice)
    }
}



