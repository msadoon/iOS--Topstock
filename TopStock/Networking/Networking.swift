import Foundation

final class TopStockNetworking: TopStockAPI, Sendable {
    static let shared = TopStockNetworking()
    
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return decoder
    }
    
    func retrieveData<T: Decodable>(for endpoint: TopStockAPIEndpoint) async throws -> T {
        let parameterizedURL: URL? = pathURL(for: endpoint)
        
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
            let decodedData = try decoder.decode(T.self, from: data)
            
            return decodedData
        } catch {
            throw DecodableError.malformedData(.malformedData)
        }
    }
    
    func pathURL(for path: TopStockAPIEndpoint) -> URL? {
        guard let validatedPath = path.validPathComponentDescription else {
            return nil
        }
                
        let baseURL = URLComponents(string: TopStockAPIEndpoint.baseEndpoint)?.url
        
        let completeURL = baseURL?.appendingPathComponent(validatedPath)
        
        return completeURL
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
}
