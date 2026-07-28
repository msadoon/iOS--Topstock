import SwiftUI

@Observable
final class MoversListViewModel {
    var gainers = [Security]()
    var losers = [Security]()
    var errorMessage: String?
    private let networking: TopStockAPI
    
    init(networking: TopStockAPI) {
        self.networking = networking
    }
    
    /**FIXME: Remove once UI/UX is complete. **/
    @MainActor
    func sampleData() async {
        let json = """
            {
              "losers": [
                {
                  "change": -45.66,
                  "symbol": "VYNE",
                  "percentChange": -98.9,
                  "price": 0.509
                },
                {
                  "change": -0.2688,
                  "symbol": "SXTC",
                  "price": 0.0638,
                  "percentChange": -80.82
                },
                {
                  "symbol": "CISS",
                  "percentChange": -45.94,
                  "change": -0.4419,
                  "price": 0.5201
                },
                {
                  "price": 0.0986,
                  "symbol": "VSTD",
                  "percentChange": -45.22,
                  "change": -0.0814
                },
                {
                  "change": -2.48,
                  "percentChange": -43.66,
                  "price": 3.2,
                  "symbol": "RBNE"
                },
                {
                  "percentChange": -39.66,
                  "change": -4.265,
                  "price": 6.49,
                  "symbol": "FFAI"
                },
                {
                  "symbol": "GSUN",
                  "percentChange": -39.6,
                  "change": -0.137,
                  "price": 0.209
                },
                {
                  "change": -0.0191,
                  "price": 0.0308,
                  "percentChange": -38.28,
                  "symbol": "JOBY.WS"
                },
                {
                  "price": 0.5005,
                  "percentChange": -37.45,
                  "change": -0.2996,
                  "symbol": "FTHAW"
                },
                {
                  "symbol": "COPL.WS",
                  "change": -0.048,
                  "percentChange": -36.89,
                  "price": 0.0821
                }
              ],
              "gainers": [
                {
                  "percentChange": 720.55,
                  "symbol": "BIOTW",
                  "price": 0.0599,
                  "change": 0.0526
                },
                {
                  "symbol": "STAK",
                  "percentChange": 602.27,
                  "price": 9.27,
                  "change": 7.95
                },
                {
                  "symbol": "LVWR",
                  "percentChange": 89.61,
                  "price": 1.46,
                  "change": 0.69
                },
                {
                  "symbol": "LVWR.WS",
                  "change": 0.009,
                  "percentChange": 66.67,
                  "price": 0.0225
                },
                {
                  "change": 0.0295,
                  "percentChange": 59,
                  "symbol": "BGLWW",
                  "price": 0.0795
                },
                {
                  "percentChange": 58.3,
                  "symbol": "WLDS",
                  "price": 3.53,
                  "change": 1.3
                },
                {
                  "percentChange": 52.71,
                  "change": 5.35,
                  "symbol": "BIOT",
                  "price": 15.5
                },
                {
                  "percentChange": 51.52,
                  "change": 0.0119,
                  "symbol": "BFRIW",
                  "price": 0.035
                },
                {
                  "change": 4.97,
                  "symbol": "NIPG",
                  "percentChange": 47.2,
                  "price": 15.5
                },
                {
                  "percentChange": 42.14,
                  "change": 0.0059,
                  "symbol": "RSVRW",
                  "price": 0.0199
                }
              ]
            }

            """
 
            do {
                let data = json.data(using: .utf8)!
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedData = try decoder.decode(Movers.self, from: data)
                
                self.gainers = decodedData.gainers
                self.losers = decodedData.losers
            } catch {
                print("error:\(error)")
                self.gainers.removeAll()
                self.losers.removeAll()
            }
        
    }
    
    func getMoversList() async {
        do {
            let movers: Movers = try await self.networking.retrieveData(for: .moversStocks)

            self.gainers = movers.gainers
            self.losers = movers.losers
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
