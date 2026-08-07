import Foundation
@testable import Topstock

final class MockTopStockNetworking: TopStockAPI {
    enum ExpectedState {
        case historicalBars
        case moversStocks
        case apiError
    }
    
    let apiError = APIError.tooManyRequestsError(APIError.APIErrorMessages.tooManyRequestsError)
    
    static var expectedState: ExpectedState = .apiError
    
    func retrieveData<T: Decodable>(for endpoint: TopStockAPIEndpoint) async throws -> T {
        switch MockTopStockNetworking.expectedState {
        case .historicalBars:
            return TestUtilities.loadJson(filename: "HistoricalBars")!
        case .moversStocks:
            return TestUtilities.loadJson(filename: "Movers")!
        case .apiError:
            throw apiError
        }
    }
}
