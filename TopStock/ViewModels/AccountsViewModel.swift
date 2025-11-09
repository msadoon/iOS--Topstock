import SwiftUI

@Observable
class AccountsViewModel {
    var custodianAccounts = [String: [Account]]()
    var errorMessage: String?
    
    func getAccountsList(for advisor: Advisor) async {
        do {
            self.custodianAccounts.removeAll()
            
            let accountsList: [Account] = try await Networking.shared.retrieveData(for: .accounts(advisor.id))
            
            accountsList.forEach { account in
                if let _ = self.custodianAccounts[account.custodian] {
                    self.custodianAccounts[account.custodian]?.append(account)
                    
                    return
                }
                
                self.custodianAccounts[account.custodian] = [account]
            }
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
