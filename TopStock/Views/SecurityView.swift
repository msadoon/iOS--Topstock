import SwiftUI

struct SecurityView: View {
    private let security: Security
    private let geometry: CGRect
    private var formattedPriceChange: String {
        String(format: GlobalVars.Text.change.rawValue, self.security.change
                .formatted(.number
                    .precision(.fractionLength(GlobalVars.Formatting.numberPrecision.rawValue))),
               self.security.percentChange.formatted()
               )
    }
    
    init(security: Security, geometry: CGRect) {
        self.security = security
        self.geometry = geometry
    }
    
    var body: some View {
        HStack {
            SymbolLogoView(symbol: self.security.symbol,
                           size: self.geometry.size)
            VStack(alignment: .leading) {
                Text(self.security.symbol)
                    .font(.headline)
                Text(self.formattedPriceChange)
                    .foregroundStyle(.primary)
                    .font(.subheadline)
                /**
                 FIXME: Ideally the backend returns the currency code, and this field is dynamic.
                 */
                     Text(self.security.price.formatted(.currency(code: GlobalVars.Text.defaultCurrency.rawValue)))
                    .foregroundStyle(.green)
                    .font(.subheadline)
            }
        }
    }
}
