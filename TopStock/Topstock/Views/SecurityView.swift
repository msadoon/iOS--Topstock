import SwiftUI

struct SecurityView: View {
    private let security: Security
    private let geometry: CGRect
    private var formattedDollarChange: String {
        String(format: GlobalVars.Text.dollarChange.rawValue, self.security.change
                .formatted(.number
                    .precision(.fractionLength(GlobalVars.Formatting.numberPrecision.rawValue))))
    }
    private var formattedPercentChange: String {
        String(format: GlobalVars.Text.percentChange.rawValue, Int(self.security.percentChange))
    }

    init(security: Security, geometry: CGRect) {
        self.security = security
        self.geometry = geometry
    }
    
    var body: some View {
        HStack(alignment: .center) {
            SymbolLogoView(symbol: self.security.symbol,
                           size: self.geometry.size)
            VStack(alignment: .trailing) {
                Text(self.security.symbol)
                    .font(.headline)
                /**
                 FIXME: Ideally the backend returns the currency code, and this field is dynamic.
                 */
                Text(self.security.price.formatted(.currency(code: GlobalVars.Text.defaultCurrency.rawValue)))
                    .bold()
                    .font(.subheadline)
                Text(self.formattedDollarChange)
                    .foregroundStyle(self.security.percentChange < 0 ? .red : .green)
                    .font(.callout)
                Text(self.formattedPercentChange)
                    .foregroundStyle(self.security.percentChange < 0 ? .red : .green)
                    .font(.callout)
            }
        }
    }
}
