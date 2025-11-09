import SwiftUI

@Observable
class MarketListViewModel {
    var markets = [String]()
    var errorMessage: String?
    
    @MainActor
    func getMarketsList() async {
        do {
            let _:[Market] = try await Networking().retrieveData(for: .screener, with: .stocksMovers)
            
            //self.markets = rawData
        } catch(let error) {
            guard let errorValue = error as? APIError else { return }
            
            switch errorValue {
            case .clientError(let message),
                    .urlError(let message),
                    .authenticationError(let message),
                    .noEndpointError(let message),
                    .serverSideError(let message),
                    .tooManyRequestsError(let message),
                    .unknown(let message):
                self.errorMessage = message.rawValue
            }
        }
    }
}
