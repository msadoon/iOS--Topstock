import SwiftUI

struct AccountsListView: View {
    private var accountsViewModel = AccountsViewModel()
    private var advisor: Advisor
    private var geometry: CGRect = .zero
    @State private var showAlert: (flag: Bool, msg: String?) = (false, nil)
    @State private var selectedHolding: Holding? = nil
    @State private var showSecurityDetails = false
    
    init(for advisor: Advisor, geometry: CGRect) {
        self.advisor = advisor
        self.geometry = geometry
    }
    
    var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    ProfilePicView(url: self.advisor.profilePictureUrl, size: self.geometry.size)
                    Text("\(self.advisor.name)")
                        .font(.title)
                        .padding()
                }
                
                List {
                    ForEach(self.accountsViewModel.custodianAccounts.keys.compactMap { String($0) }.sorted(), id: \.self) { custodianName in
                        Section(header:
                                    Label(custodianName,
                                          systemImage: GlobalVars.ImageSymbols.custodian.rawValue)) {
                            ForEach(self.accountsViewModel.custodianAccounts[custodianName] ?? []) { account in
                                AccountView(account: account,
                                          holding: self.$selectedHolding)
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle(GlobalVars.Text.accounts.rawValue)
            .onChange(of: self.accountsViewModel.errorMessage) { _, newMessage in
                guard let messageValue = newMessage else { return }
                
                self.showAlert = (true, messageValue)
            }
            .onChange(of: self.selectedHolding) { _, newValue in
                guard newValue != nil else { return }
                
                self.showSecurityDetails = true
            }
            .task {
                let _ = await self.accountsViewModel.getAccountsList(for: self.advisor)
            }
            .sheet(isPresented: self.$showSecurityDetails, onDismiss: { self.selectedHolding = nil }) {
                if let availableHolding = self.selectedHolding {
                    SecurityDetailsView(holding: availableHolding)
                        .presentationDetents([.medium])
                }
            }
    }
}

