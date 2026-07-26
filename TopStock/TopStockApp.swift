import SwiftUI

@main
struct TopStockApp: App {
    var body: some Scene {
        WindowGroup {
            MoversListView()
                .preferredColorScheme(.dark)
        }
    }
}
