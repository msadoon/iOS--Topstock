import SwiftUI

struct GraphableCandleStick: Identifiable {
    let id: String
    let hour: Int
    let minute: Int
    /** FIXME: There will be more data here for the candle stick. */
    let closePrice: Float
    
    var descriptionOfTime: String {
        "\(self.hour): \(self.minute)"
    }
}

@MainActor @Observable
final class HistoricalBarsViewModel {
    var candlesticks = [GraphableCandleStick]()
    var errorMessage: String?
    private let networking: TopStockAPI
    private let symbol: String
    
    init(networking: TopStockAPI,
         for symbol: String) {
        self.networking = networking
        self.symbol = symbol
    }
    
    /// FIXME: Get this per day with some pagination after implementing scrolling chart.
    func getHistoricalBars(for timeFrame: SnapshotPeriod) async {
        /** FIXME: This is a limitation of the "free" subscription level of the Alpaca endpoint. Cannot get today's candlesticks as historical data. Explore subscription pricing.*/
        let latestAvailableDataDate = Utilities.lastWeekDay(from: .now)
        let timeFrameValue: TopStockAPIEndpoint.HistoricalBarTimeFrame = timeFrame == .fiveMin ? .FiveMin : .OneHour
        do {
            let historicalBars: HistoricalBars = try await self.networking.retrieveData(for: .historicalBars(self.symbol, timeFrameValue, latestAvailableDataDate))
            
            let _ =  self.updateChartView(with:  historicalBars)
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
    
    private func updateChartView(with historicalBars: HistoricalBars) {
        Task { @MainActor in
            let candlesticks: [GraphableCandleStick] = historicalBars.bars.compactMap { candlestick -> GraphableCandleStick? in
                let hourAndMinute = Utilities.formattedTime(for: candlestick.timestamp)
                guard let hour = hourAndMinute.first?.key,
                      let minute = hourAndMinute.first?.value else {
                    return nil
                }
                
                return GraphableCandleStick(id: historicalBars.symbol + "\(hour)\(minute)",
                                            hour: hour,
                                            minute: minute,
                                            closePrice: candlestick.closePrice)
            }
            
            self.candlesticks = candlesticks
        }
    }
}
