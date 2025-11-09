import SwiftUI

struct AdvisorView: View {
    private var advisor: Advisor
    private var geometry: CGRect
    
    init(advisor: Advisor, geometry: CGRect) {
        self.geometry = geometry
        self.advisor = advisor
    }
    
    var body: some View {
        HStack {
            ProfilePicView(url: self.advisor.profilePictureUrl, size: self.geometry.size)
            VStack(alignment: .leading) {
                Text(advisor.name)
                    .font(.headline)
                Text(GlobalVars.Text.numAccounts.rawValue + "\(advisor.portfolioSummary.count)")
                    .foregroundStyle(.primary)
                    .font(.subheadline)
                /**
                 FIXME: Ideally the backend returns the currency code, and this field is dynamic.
                 */
                Text(advisor.totalAssets.formatted(.currency(code: GlobalVars.Text.defaultCurrency.rawValue)))
                    .foregroundStyle(.green)
                    .font(.subheadline)
            }
        }
    }
}
