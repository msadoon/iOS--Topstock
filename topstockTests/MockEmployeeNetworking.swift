import Foundation
@testable import td_code_challenge

final class MockEmployeeNetworking: EmployeeAPI {
    enum ExpectedState {
        case nonEmpty
        case empty
        case apiError
        case decodeError
    }
    
    let apiError = APIError.tooManyRequestsError(APIError.APIErrorMessages.tooManyRequestsError)
    let decodeError = DecodableError.malformedData(.malformedData)
    
    var expectedState: ExpectedState = .decodeError
    
    func retrieveData<T: Decodable>(for endpoint: EmployeeAPIEndpoint.Fragment) async throws -> T {
        switch expectedState {
        case .nonEmpty:
            return TestUtilities.loadJson(filename: "Employees")!
        case .empty:
            return TestUtilities.loadJson(filename: "EmptyEmployees")!
        case .apiError:
            throw apiError
        case .decodeError:
            throw decodeError
        }
    }
}
