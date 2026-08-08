import SwiftUI

struct SecurityDetailsView: View {
    @State private var selectedSnapshot: SnapshotPeriod = .fiveMin
    private var security: Security
    private var logoURL: URL? {
        let endpoint = TopStockAPIEndpoint.logos(self.security.symbol)
        return self.networking.pathURL(for: endpoint)
    }
    
    private let networking: TopStockAPI
    
    init(networking: TopStockAPI,
         security: Security) {
        self.networking = networking
        self.security = security
    }
    
    var body: some View {
        ScrollView {
            HStack {
                AsyncImage(url: self.logoURL)
                    .aspectRatio(contentMode: .fit)
                    .padding()
                VStack {
                    Text(self.security.symbol)
                        .font(.title)
                    Text(self.security.price.formatted(.currency(code: GlobalVars.Text.defaultCurrency.rawValue)))
                        .bold()
                        .font(.subheadline)
                    Text(Utilities.formattedDollarChange(for: self.security))
                        .foregroundStyle(self.security.percentChange < 0 ? .red : .green)
                        .font(.callout)
                    Text(Utilities.formattedPercentChange(for: self.security))
                        .foregroundStyle(self.security.percentChange < 0 ? .red : .green)
                        .font(.callout)
                }
            }
            Picker(selection: self.$selectedSnapshot) {
                ForEach(SnapshotPeriod.allCases, id: \.self) { option in
                    Text(option.description)
                }
            } label: {
                Text(GlobalVars.Text.TimeLine.timePeriod)
            }
            .pickerStyle(.segmented)
            .padding()
            
            TimeLineChartView(networking: self.networking,
                              for: self.security.symbol,
                              in: $selectedSnapshot)
        }
        .padding()
    }
}

