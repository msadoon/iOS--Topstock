import SwiftUI

struct MoversListView: View {
    @Environment(MoversListViewModel.self) private var moversListViewModel
    @State private var showAlert: (flag: Bool, msg: String?) = (false, nil)
    @State var geometry = CGRect.zero
    
    var body: some View {
        NavigationStack {
            VStack {/**
                List {
                    Section(header:
                                HStack {
                        Label(GlobalVars.Text.gainers.rawValue,
                              systemImage: GlobalVars.ImageSymbols.gainers.rawValue)
                    })
                        {
                        ForEach(self.moversListViewModel.gainers, id: \.id) { security in
                            SecurityView(security: security,
                                         geometry: self.geometry)
                        }
                    }
                        .headerProminence(.increased)
                    
                    Section(header:
                                HStack {
                        Label(GlobalVars.Text.losers.rawValue,
                              systemImage: GlobalVars.ImageSymbols.losers.rawValue)
                    })
                        {
                        ForEach(self.moversListViewModel.losers, id: \.id) { security in
                            SecurityView(security: security,
                                         geometry: self.geometry)
                        }
                    }
                        .headerProminence(.increased)
                }
                .listStyle(.plain)
                     */
                Text("Display test")
            }
            .navigationTitle(GlobalVars.Brand.title.rawValue)
            //.navigationBarTitleDisplayMode(.inline)
            .onChange(of: self.moversListViewModel.errorMessage) { _, newMessage in
                guard let messageValue = newMessage else { return }
                
                self.showAlert = (true, messageValue)
            }
            .onGeometryChange(for: CGRect.self) { proxy in
                let viewFrame = proxy.frame(in: .local)
                
                return viewFrame
            } action: { newValue in
                self.geometry = newValue
            }
        }
        .task {
            let _ = await self.moversListViewModel.sampleData()
        }
    }
}
