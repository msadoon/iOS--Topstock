import SwiftUI

@main
struct TopStockApp: App {
    var body: some Scene {
        WindowGroup {
            MarketListView()
                .preferredColorScheme(.dark)
        }
    }
}
