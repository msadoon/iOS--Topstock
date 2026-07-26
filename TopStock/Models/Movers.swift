import Foundation

struct Movers: Decodable, Identifiable {
    let id: UUID
    let gainers: [Security]
    let losers: [Security]
    
    init(gainers: [Security], losers: [Security]) {
        self.id = UUID()
        self.gainers = gainers
        self.losers = losers
    }
}
