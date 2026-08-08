import SwiftUI

fileprivate enum SectionType {
    case gainers
    case losers
}

struct MoversListView: View {
    @State private var showAlert: (flag: Bool, msg: String?) = (false, nil)
    @State private var geometry = CGRect.zero
    @State private var showSecurityDetails = false
    @State private var selectedSecurity: Security?
    private var viewModel: MoversListViewModel
    private let networking: TopStockAPI
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    init(networking: TopStockAPI) {
        self.networking = networking
        self.viewModel = MoversListViewModel(networking: networking)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    section(for: self.viewModel.gainers,
                            in: self.columns,
                            with: self.geometry,
                            type: .gainers,
                            selectedSecurity: $selectedSecurity)
                    
                    section(for: self.viewModel.losers,
                            in: self.columns,
                            with: self.geometry,
                            type: .losers,
                            selectedSecurity: $selectedSecurity)
                    
                }
            }
            .navigationTitle(GlobalVars.Brand.title.rawValue)
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: self.viewModel.errorMessage) { _, newMessage in
                guard let messageValue = newMessage else { return }
                
                self.showAlert = (true, messageValue)
            }
            .onGeometryChange(for: CGRect.self) { proxy in
                let viewFrame = proxy.frame(in: .local)
                
                return viewFrame
            } action: { newValue in
                self.geometry = newValue
            }
            .onAppear {
                Task { @MainActor
                    let _ = await self.viewModel.getMoversList()
                }
            }
            .onChange(of: self.selectedSecurity) { _, newValue in
                guard let _ = newValue else {
                    self.showSecurityDetails = false
                    return
                }
                
                self.showSecurityDetails = true
            }
            .sheet(isPresented: self.$showSecurityDetails, onDismiss: { self.selectedSecurity = nil }) {
                if let availableSecurity = self.selectedSecurity {
                    SecurityDetailsView(networking: self.networking, security: availableSecurity)
                        .presentationDetents([.medium])
                }
            }
        }
    }
    
    @ViewBuilder
    private func section(for movers: [Security],
                         in columns: [GridItem],
                         with geometry: CGRect,
                         type: SectionType,
                         selectedSecurity: Binding<Security?>) -> some View {
        let sectionTitle = type == .gainers ? GlobalVars.Text.gainers.rawValue : GlobalVars.Text.losers.rawValue
        
        let sectionImage = type == .gainers ? GlobalVars.ImageSymbols.gainers.rawValue : GlobalVars.ImageSymbols.losers.rawValue
        
        Section(header:
                    HStack {
            Label(sectionTitle,
                  systemImage: sectionImage)
            Spacer()
        })
        {
            LazyVGrid(columns: columns) {
                ForEach(movers, id: \.id) { security in
                    SecurityView(security: security,
                                 geometry: geometry)
                    .onTapGesture {
                        selectedSecurity.wrappedValue = security
                    }
                }
            }
        }
        .headerProminence(.increased)
    }
}
