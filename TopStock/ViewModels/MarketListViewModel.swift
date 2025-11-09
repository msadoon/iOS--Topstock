import SwiftUI

@Observable
class MarketListViewModel {
    var advisors = [Advisor]()
    var errorMessage: String?
    
    func getMarketsList() async {
        do {
            let advisorList: [Advisor] = try await Networking.shared.retrieveData(for: .advisors)
            
            self.advisors = advisorList
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
