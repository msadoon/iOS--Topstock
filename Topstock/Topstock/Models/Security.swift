import Foundation

struct Security: Decodable, Identifiable {
    var id: String {
       symbol
    }
    
    let symbol: String
    let percentChange: Float
    let change: Float
    let price: Float
}
