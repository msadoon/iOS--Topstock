import Foundation

struct Movers: Decodable {
    let gainers: [Security]
    let losers: [Security]
    
    init(gainers: [Security], losers: [Security]) {
        self.gainers = gainers
        self.losers = losers
    }
}
