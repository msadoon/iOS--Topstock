import SwiftUI

struct MoversListView: View {
    private var moversListViewModel = MoversListViewModel()
    @State private var showAlert: (flag: Bool, msg: String?) = (false, nil)
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyHGrid(rows: [GridItem(.fixed(GlobalVars.Padding.fifty.rawValue))], spacing: GlobalVars.Padding.ten.rawValue) {
                    ForEach(self.moversListViewModel.securities) { security in
                        Button {
                            // self.$selectedHolding.wrappedValue = holding
                        } label: {
                            VStack(alignment: .leading) {
                                Text(security.symbol)
                                    .fontDesign(.monospaced)
                                    .fontWidth(.expanded)
                                    .fontWeight(.semibold)
                                Text("\(security.percentChange)")
                                    .fontDesign(.monospaced)
                                    .fontWidth(.condensed)
                                    .fontWeight(.light)
                                Text(security.change.formatted(.currency(code: GlobalVars.Text.defaultCurrency.rawValue)))
                                    .fontDesign(.monospaced)
                                    .fontWidth(.condensed)
                                    .fontWeight(.light)
                                Text(security.price.formatted(.currency(code: GlobalVars.Text.defaultCurrency.rawValue)))
                                    .fontDesign(.monospaced)
                                    .fontWidth(.condensed)
                                    .fontWeight(.light)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                    }
                }
            }
            .navigationTitle(GlobalVars.Brand.title.rawValue)
            .navigationBarTitleDisplayMode(.inline)
            /**
            .onChange(of: self.advisorViewModel.errorMessage) { _, newMessage in
                guard let messageValue = newMessage else { return }
                
                self.showAlert = (true, messageValue)
            }
             */
        }
        .task {
            let _ = await self.moversListViewModel.getMoversList()
        }
    }
}
