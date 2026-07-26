import SwiftUI

@Observable
final class MoversListViewModel {
    var securities = [Security]()
    var errorMessage: String?
    
    @MainActor
    func getMoversList() async {
        do {
            let movers: Movers = try await TopStockNetworking.shared.retrieveData(for: .moversStocks)

            self.securities = movers.gainers + movers.losers
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
