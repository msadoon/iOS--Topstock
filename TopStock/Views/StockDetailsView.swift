import SwiftUI

struct StockDetailsView: View {
    @State private var selectedSnapshot: SnapshotPeriod = .sevenDay
    private var securitiesViewModel = SecurityViewModel()
    private var holding: Holding
    
    init(holding: Holding) {
        self.holding = holding
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let availableSecurity = securitiesViewModel.security {
                Text(availableSecurity.name)
                    .font(.title2)
                Text(availableSecurity.ticker)
                    .font(.title3)
                Text(availableSecurity.exchange.rawValue)
                    .font(.body)
                Text(GlobalVars.Text.dateAdded.rawValue + (availableSecurity.dateAdded?.formatted(date: .abbreviated, time: .omitted) ?? ""))
                    .font(.callout)
                // FIXME: In production, this would be mapped to the snapshot periods for the security.
                Picker(selection: self.$selectedSnapshot) {
                    ForEach(SnapshotPeriod.allCases, id: \.self) { option in
                        Text(option.description)
                    }
                } label: {
                    Text(GlobalVars.Text.Exchange.timePeriod.rawValue)
                }
                .pickerStyle(.segmented)
                .padding()
                
                // FIXME: In production, this would be mapped to the snapshot periods for the security.
                Image("snapshot_sample")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    
            } else {
                Text(GlobalVars.Text.generalError.rawValue)
                    .font(.headline)
            }
        }
        .padding()
        .task {
            let _ = await securitiesViewModel.getSecurity(for: self.holding)
        }
    }
}

