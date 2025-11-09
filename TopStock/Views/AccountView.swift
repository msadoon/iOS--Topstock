import SwiftUI

/**
 FIXME: There is a rare bug that sometimes doesn't load this view, the account needs to be re-entered to load it. TBD.
 */
/**
 FIXME: This is also a crash that happens infrequently. TBD.
 Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[__NSCFNumber countByEnumeratingWithState:objects:count:]: unrecognized selector sent to instance 0x8000000000000000'
 */

struct AccountView: View {
    private var account: Account
    @Binding private var selectedHolding: Holding?
    
    init(account: Account, holding: Binding<Holding?>) {
        self.account = account
        self._selectedHolding = holding
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(account.name)
                .font(.headline)
            Text("\(GlobalVars.Text.accountNum.rawValue) " + account.number)
                .font(.subheadline)
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.fixed(GlobalVars.Padding.hundred.rawValue))], spacing: GlobalVars.Padding.ten.rawValue) {
                    ForEach(self.account.holdings, id: \.ticker) { holding in
                        Button {
                            self.$selectedHolding.wrappedValue = holding
                        } label: {
                            VStack(alignment: .leading) {
                                Text(holding.ticker)
                                    .fontDesign(.monospaced)
                                    .fontWidth(.expanded)
                                    .fontWeight(.semibold)
                                Text("\(holding.units)")
                                    .fontDesign(.monospaced)
                                    .fontWidth(.condensed)
                                    .fontWeight(.light)
                                /**
                                 FIXME: Ideally the backend returns the currency code, and this field is dynamic.
                                 */
                                Text(holding.unitPrice.formatted(.currency(code: GlobalVars.Text.defaultCurrency.rawValue)))
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
        }
    }
}
