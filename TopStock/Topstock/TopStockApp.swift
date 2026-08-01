import SwiftUI

@main
struct TopStockApp: App {
    @State private var moversViewModel = MoversListViewModel(networking: TopStockNetworking.shared)
    
    var body: some Scene {
        WindowGroup {
            MoversListView()
                .environment(self.moversViewModel)
                .preferredColorScheme(.dark)
        }
    }
}
