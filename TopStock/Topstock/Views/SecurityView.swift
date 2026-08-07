import SwiftUI

struct SecurityView: View {
    private let security: Security
    private let geometry: CGRect


    init(security: Security, geometry: CGRect) {
        self.security = security
        self.geometry = geometry
    }
    
    var body: some View {
        HStack(alignment: .center) {
            SymbolLogoView(symbol: self.security.symbol,
                           size: self.geometry.size)
            VStack(alignment: .leading) {
                Text(self.security.symbol)
                    .font(.headline)
                /**
                 FIXME: Ideally the backend returns the currency code, and this field is dynamic.
                 */
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
    }
}
