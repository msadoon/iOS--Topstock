import SwiftUI

@main
struct TopStockApp: App {
    private let topstockAPI: TopStockAPI
    
    init() {
        self.topstockAPI = TopStockNetworking.shared
    }
    
    var body: some Scene {
        WindowGroup {
            MoversListView(networking: self.topstockAPI)
                .preferredColorScheme(.dark)
        }
    }
}
