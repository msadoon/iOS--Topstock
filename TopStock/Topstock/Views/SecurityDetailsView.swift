import SwiftUI

fileprivate enum SnapshotPeriod: String, CaseIterable {
    case fiveMin
    case oneHour
    
    var description: String {
        switch self {
        case .fiveMin:
            GlobalVars.Text.Exchange.fiveMinPeriod.rawValue
        case .oneHour:
            GlobalVars.Text.Exchange.oneHourPeriod.rawValue
        }
    }
}

struct SecurityDetailsView: View {
    @State private var selectedSnapshot: SnapshotPeriod = .fiveMin
    private var security: Security
    private var logoURL: URL? {
        let endpoint = TopStockAPIEndpoint.logos(self.security.symbol)
        return TopStockNetworking.shared.pathURL(for: endpoint)
    }
    
    init(security: Security) {
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
            /**
                Text(availableSecurity.ticker)
                    .font(.title3)
                Text(availableSecurity.exchange.rawValue)
                    .font(.body)
                Text(GlobalVars.Text.dateAdded.rawValue + (availableSecurity.dateAdded?.formatted(date: .abbreviated, time: .omitted) ?? ""))
                    .font(.callout)
                // FIXME: In production, this would be mapped to the snapshot periods for the security.
             */
                Picker(selection: self.$selectedSnapshot) {
                    ForEach(SnapshotPeriod.allCases, id: \.self) { option in
                        Text(option.description)
                    }
                } label: {
                    Text(GlobalVars.Text.Exchange.timePeriod.rawValue)
                }
                .pickerStyle(.segmented)
                .padding()
        }
        .padding()
    }
}

