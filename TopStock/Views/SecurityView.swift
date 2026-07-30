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
    
//    "\(Int(self.security.percentChange.rounded()))"
    
    init(security: Security, geometry: CGRect) {
        self.security = security
        self.geometry = geometry
    }
    
    var body: some View {
        HStack {
            SymbolLogoView(symbol: self.security.symbol,
                           size: self.geometry.size)
            VStack(alignment: .leading) {
                HStack {Text(self.security.symbol)
                        .font(.headline)
                    Spacer()
                    /**
                     FIXME: Ideally the backend returns the currency code, and this field is dynamic.
                     */
                    Text(self.security.price.formatted(.currency(code: GlobalVars.Text.defaultCurrency.rawValue)))
                        .bold()
                        .font(.subheadline)
                }
                
                HStack {
                    Text(self.formattedDollarChange)
                        .foregroundStyle(self.security.percentChange < 0 ? .red : .green)
                        .font(.callout)
                    Spacer()
                    Text(self.formattedPercentChange)
                        .foregroundStyle(self.security.percentChange < 0 ? .red : .green)
                        .font(.callout)
                }
                Spacer()
            }
        }
    }
}
