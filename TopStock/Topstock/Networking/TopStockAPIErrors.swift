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

enum DecodableError: Error {
    enum DecodeErrorMessages: String {
        case malformedData = "Malformed error."
    }
    
    case malformedData(DecodeErrorMessages)
}
