import SwiftUI

@main
struct TopStockApp: App {
    @State private var moversViewModel = MoversListViewModel(networking: TopStockNetworking.shared)
    @State private var historicalBarsViewModel = HistoricalBarsViewModel(networking: TopStockNetworking.shared)
    
    var body: some Scene {
        WindowGroup {
            MoversListView()
                .environment(self.moversViewModel)
                .environment(self.historicalBarsViewModel)
                .preferredColorScheme(.dark)
        }
    }
}
