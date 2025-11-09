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

enum TopStockAPIEndpoint: String {
    case baseEndpoint = "https://data.alpaca.markets/v1beta1"
    
    enum Fragment: String {
        case screener = "screener"
        
        enum Description: String {
            case stocksActive = "stocks/most-actives"
            case stocksMovers = "stocks/movers"
            case cryptoMovers = "crypto/movers"
        }
    }
}

protocol TopStockAPI {
    func retrieveData<T: Decodable>(for: TopStockAPIEndpoint.Fragment, with description: TopStockAPIEndpoint.Fragment.Description) async throws -> [T] where T: Identifiable
}

struct Networking: TopStockAPI {
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return decoder
    }
    
    private var fragmentURL: (TopStockAPIEndpoint.Fragment, TopStockAPIEndpoint.Fragment.Description) -> URL? = { fragment, description in
        var baseURL = URLComponents(string: TopStockAPIEndpoint.baseEndpoint.rawValue)?.url
        
        let screenerComponent = URLComponents(string: fragment.rawValue)?.url(relativeTo: baseURL)
        let moverComponent = URLComponents(string: description.rawValue)?.url(relativeTo: screenerComponent)

        guard let completeURLComponent = moverComponent else {
            return baseURL
        }
        
        return completeURLComponent
    }
    
    func retrieveData<T: Decodable>(for endpoint: TopStockAPIEndpoint.Fragment, with description: TopStockAPIEndpoint.Fragment.Description) async throws -> [T] where T: Identifiable {
        let parameterizedURL: URL? = fragmentURL(endpoint, description)
        
        guard let validURL = parameterizedURL else {
            throw APIError.urlError(APIError.APIErrorMessages.urlError)
        }
        
        let (data, urlResponse) = try await URLSession.shared.data(from: validURL)
        
        guard let httpsURLResponse = (urlResponse as? HTTPURLResponse) else {
            throw APIError.unknown(APIError.APIErrorMessages.unknown)
        }
        
        let errorState = errorState(in: httpsURLResponse)
        
        guard errorState == nil else {
            throw errorState ?? APIError.unknown(APIError.APIErrorMessages.unknown)
        }
        
        do {
            let parsedJSON = try self.decoder.decode([T].self, from: data)
            print(parsedJSON)
            return parsedJSON
        } catch(let error) {
            throw error
        }
    }
    
    private func errorState(in response: HTTPURLResponse) -> APIError? {
        var validError: APIError?
        
        switch response.statusCode {
            case 200..<299:
                validError = nil
            case 400:
                validError = APIError.clientError(APIError.APIErrorMessages.clientError)
            case 401:
                validError = APIError.authenticationError(APIError.APIErrorMessages.authenticationError)
            case 403, 404:
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
}
