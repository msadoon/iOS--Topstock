import Foundation

struct AccountPreview: Decodable, Hashable {
    let name: String
    let id: String
    let totalAssets: Double
}

struct Market: Decodable, Hashable, Identifiable {
    let id: String
    let acronym: String
    let fullName: URL?
    let portfolioSummary: [AccountPreview]
    
    var totalAssets: Double {
        portfolioSummary.reduce(0.0, { $0 + $1.totalAssets })
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case accounts
        case profileUrl
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        
        var profileURL: URL?
        
        if let profileURLRawValue = try container.decodeIfPresent(String.self, forKey: .profileUrl),
           let url = URL(string: profileURLRawValue) {
            profileURL = url
        }
        
        self.profilePictureUrl = profileURL
        self.portfolioSummary = try container.decode([AccountPreview].self, forKey: .accounts)
    }
}


