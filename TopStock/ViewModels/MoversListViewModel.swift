import SwiftUI

@MainActor @Observable
final class MoversListViewModel {
    var gainers = [Security]()
    var losers = [Security]()
    var errorMessage: String?
    private let networking: TopStockAPI
    
    init(networking: TopStockAPI) {
        self.networking = networking
    }
    
    func getMoversList() async {
        do {
            let movers: Movers = try await self.networking.retrieveData(for: .moversStocks)
            
            let _ =  self.updateListView(movers: movers)
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
    
    private func updateListView(movers: Movers) {
        Task { @MainActor in
            self.gainers = movers.gainers
            self.losers = movers.losers
        }
    }
}
