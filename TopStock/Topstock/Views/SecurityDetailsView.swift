import SwiftUI

fileprivate enum SnapshotPeriod: String, CaseIterable {
    case sevenDay = "7_day"
    case sixMonth = "6_month"
    case oneYear = "1_year"
    
    var description: String {
        switch self {
        case .sevenDay:
            GlobalVars.Text.Exchange.sevenDayPeriod.rawValue
        case .sixMonth:
            GlobalVars.Text.Exchange.sixMonthDayPeriod.rawValue
        case .oneYear:
            GlobalVars.Text.Exchange.oneYearPeriod.rawValue
        }
    }
}

struct SecurityDetailsView: View {
    @State private var selectedSnapshot: SnapshotPeriod = .sevenDay
    private var security: Security
    private var logoURL: URL? {
        let endpoint = TopStockAPIEndpoint.logos(self.security.symbol)
        return TopStockNetworking.shared.pathURL(for: endpoint)
    }
    
    init(security: Security) {
        self.security = security
    }
    
    var body: some View {
        VStack(alignment: .leading) {
                Text(self.security.symbol)
                    .font(.title2)
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
                
            AsyncImage(url: self.logoURL)
                    .aspectRatio(contentMode: .fit)
                    .padding()
        }
        .padding()
    }
}

