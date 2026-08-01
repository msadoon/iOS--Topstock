import SwiftUI

struct SymbolLogoView: View {
    private let symbol: String
    private let size: CGSize
    private var logoURL: URL? {
        let endpoint = TopStockAPIEndpoint.logos(self.symbol)
        return TopStockNetworking.shared.pathURL(for: endpoint)
    }
    
    init(symbol: String,
         size: CGSize) {
        self.symbol = symbol
        self.size = size
    }
    
    var body: some View {
        AsyncImage(url: self.logoURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            Image(systemName: GlobalVars.ImageSymbols.placeholder.rawValue)
        }
        .frame(width: self.size.width * GlobalVars.ImageStyling.relativeWidthOneFifth.rawValue)
        .clipShape(.rect(cornerRadius: GlobalVars.ImageStyling.cornerRadius.rawValue))
        
    }
}
