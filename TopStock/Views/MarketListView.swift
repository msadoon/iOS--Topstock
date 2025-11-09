import SwiftUI

struct MarketListView: View {
    /**
    private var marletListViewModel = MarketListViewModel()
     */
    @State var geometry = CGRect.zero
    @State private var showAlert: (flag: Bool, msg: String?) = (false, nil)
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section(header:
                                HStack {
                        Label(GlobalVars.Text.advisors.rawValue,
                              systemImage: GlobalVars.ImageSymbols.market.rawValue)
                    }
                    ) {
                        /**
                        ForEach(self.advisorViewModel.advisors.sorted(by: { currentAdvisor, nextAdvisor in
                            switch self.filterBy {
                                case GlobalVars.Action.sortByName:
                                currentAdvisor.name <= nextAdvisor.name
                                default:
                                currentAdvisor.totalAssets >= nextAdvisor.totalAssets
                            }
                        }
                                                                     )) { advisor in
                            NavigationLink(destination: AccountsListView(for: advisor, geometry: self.geometry)) {
                                AdvisorView(advisor: advisor, geometry: self.geometry)
                            }
                        }
                         */
                        EmptyView()
                    }
                    .headerProminence(.increased)
                }
                .listStyle(.plain)
            }
            .navigationTitle(GlobalVars.Brand.title.rawValue)
            .navigationBarTitleDisplayMode(.inline)
            /**
            .onChange(of: self.advisorViewModel.errorMessage) { _, newMessage in
                guard let messageValue = newMessage else { return }
                
                self.showAlert = (true, messageValue)
            }
             */
            .onGeometryChange(for: CGRect.self) { proxy in
                let viewFrame = proxy.frame(in: .local)
                
                return viewFrame
            } action: { newValue in
                self.geometry = newValue
            }
        }
        .task {
            /**
            let _ = await self.marletListViewModel.getAdvsiorList()
             */
        }
    }
}
