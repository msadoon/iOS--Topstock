import Foundation

enum APIError: Error {
    enum APIErrorMessages: String {
        case clientError = "Client side error."
        case urlError = "Invalid URL."
        case authenticationError = "Authentication issue."
        case noEndpointError = "Endpoint does not exist."
        case tooManyRequestsError = "Request limit exceeded."
        case serverSideError = "Server side error."
        case unknown = "unknown"
    }
    
    case clientError(APIErrorMessages)
    case urlError(APIErrorMessages)
    case authenticationError(APIErrorMessages)
    case noEndpointError(APIErrorMessages)
    case tooManyRequestsError(APIErrorMessages)
    case serverSideError(APIErrorMessages)
    case unknown(APIErrorMessages)
}

enum AdvisorDashboardAPIEndpoint: String {
    case baseEndpoint = "https://api.compoundplanning.com/v2"
    
    enum Fragment {
        case advisors
        case accounts(String)
        case ticker(String)
        
        enum Description: String {
            case advisors = "/advisors"
            case accounts = "/accounts/"
            case ticker = "/symbol/"
        }
    }
}

protocol AdvisorDashboardAPI {
    func retrieveData<T: Decodable>(for: AdvisorDashboardAPIEndpoint.Fragment) async throws -> [T] where T: Identifiable
}

class Networking: AdvisorDashboardAPI {
    static let shared = Networking()
    private var decoder = JSONDecoder()
    private let cachedAccounts: [Account] = Utilities.shared.loadJson(filename: "Accounts")
    private let cachedAdvisors: [Advisor] = Utilities.shared.loadJson(filename: "Advisors")
    private let cachedSecurities: [Security] = Utilities.shared.loadJson(filename: "Securities")
    /**
        FIXME: In a production application, think about pagination for three different endpoints. It would be stored and updated within this url below.
     */
    private var fragmentURL: (AdvisorDashboardAPIEndpoint.Fragment) -> URL? = { fragment in
        var baseURL = URLComponents(string: AdvisorDashboardAPIEndpoint.baseEndpoint.rawValue)?.url
        
        var queryItem: URLQueryItem?
        
        switch fragment {
        case .advisors:
            queryItem = URLQueryItem(name: AdvisorDashboardAPIEndpoint.Fragment.Description.advisors.rawValue, value: "")
        case .accounts(let advisorId):
            queryItem = URLQueryItem(name: AdvisorDashboardAPIEndpoint.Fragment.Description.accounts.rawValue, value: advisorId)
        case .ticker(let symbol):
            queryItem = URLQueryItem(name: AdvisorDashboardAPIEndpoint.Fragment.Description.ticker.rawValue, value: symbol)
        }
        
        guard let availableQueryItem = queryItem else {
            return baseURL
        }
        
        let completeURL = baseURL?.appending(queryItems: [availableQueryItem])
        
        return completeURL
    }
    
    func retrieveData<T: Decodable>(for endpoint: AdvisorDashboardAPIEndpoint.Fragment) async throws -> [T] where T: Identifiable {
        let parameterizedURL: URL? = fragmentURL(endpoint)
        
        guard let _ = parameterizedURL else {
            throw APIError.urlError(APIError.APIErrorMessages.urlError)
        }
        /** FIXME: In a real production app - we'd be hitting a network - so handling error states becomes important.
        let (data, urlResponse) = try await URLSession.shared.data(from: validURL)
        
        guard let httpsURLResponse = (urlResponse as? HTTPURLResponse) else {
            throw APIError.unknown(APIError.APIErrorMessages.unknown)
        }
        
        let errorState = errorState(in: httpsURLResponse)
        
        guard errorState == nil else {
            throw errorState ?? APIError.unknown(APIError.APIErrorMessages.unknown)
        }
         */
        /**
            FIXME: These act as the backend/local cache for the models in the JSON.
          */
        switch endpoint {
        case .advisors:
            return Utilities.shared.loadJson(filename: "Advisors")
        case .accounts(let advisorId):
            guard let advisor: Advisor = self.cachedAdvisors.first(where: { $0.id == advisorId }) else {
                return []
            }
            
            let uniqueClientIds: Set<String> = Set(advisor.portfolioSummary.map { $0.id })
            
            return Utilities.shared.loadJson(filename: "Accounts").filter { account in
                guard let accountId: String = account.id as? String else {
                    return false
                }
                
                return uniqueClientIds.contains(accountId)
            }
        case .ticker(let symbol):
            guard let foundSecurity = self.cachedSecurities.first(where: { $0.ticker == symbol }) else {
                return []
            }
            
            return  Utilities.shared.loadJson(filename: "Securities").filter { security in
                guard let securityId: String = security.id as? String else {
                    return false
                }
                
                return foundSecurity.id == securityId
            }
        }
    }
    
    /**
    FIXME: Real networking would use this for error handling
     
    private func errorState(in response: HTTPURLResponse) -> APIError? {
        var validError: APIError?
        
        switch response.statusCode {
            case 200..<299:
                validError = nil
            case 400:
                validError = APIError.clientError(APIError.APIErrorMessages.clientError)
            case 401:
                validError = APIError.authenticationError(APIError.APIErrorMessages.authenticationError)
            case 404:
                validError = APIError.noEndpointError(APIError.APIErrorMessages.noEndpointError)
            case 429:
                validError = APIError.tooManyRequestsError(APIError.APIErrorMessages.tooManyRequestsError)
            case 500:
                validError = APIError.serverSideError(APIError.APIErrorMessages.serverSideError)
            default:
                validError = APIError.unknown(APIError.APIErrorMessages.unknown)
        }
        
        return validError
    }
     */
}
