import Foundation

struct Holding: Decodable, Hashable {
    let ticker: String
    let units: Int
    let unitPrice: Double
}

struct Account: Decodable, Hashable, Identifiable {
    let id: String
    let name: String
    let number: String
    let custodian: String
    let holdings: [Holding]
    
    enum CodingKeys: CodingKey {
        case id
        case number
        case name
        case custodian
        case holdings
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.number = try container.decode(String.self, forKey: .number)
        self.custodian = try container.decode(String.self, forKey: .custodian)
        self.holdings = try container.decode([Holding].self, forKey: .holdings)
    }
}

