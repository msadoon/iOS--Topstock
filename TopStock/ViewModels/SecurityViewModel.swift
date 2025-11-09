import SwiftUI

@Observable
class SecurityViewModel {
    var security: Security?
    var errorMessage: String?
    
    func getSecurity(for holding: Holding) async {
        do {
            let security: [Security] = try await Networking.shared.retrieveData(for: .ticker(holding.ticker))
            
            guard let availableSecurity = security.first else {
                self.security = nil
                
                return
            }
            
            self.security = availableSecurity
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
