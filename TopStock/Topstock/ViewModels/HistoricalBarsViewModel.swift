import SwiftUI

struct GraphableCandleStick: Identifiable {
    var id: String
    var time: Int
    var closePrice: Float
}

@MainActor @Observable
final class HistoricalBarsViewModel {
    var candlesticks = [GraphableCandleStick]()
    var errorMessage: String?
    private let networking: TopStockAPI
    private let timeFrame: GlobalVars.Text.TimeLine
    
    /// FIXME: Make time frame more dynamic. Should be bound to the picker in the detail view.
    init(networking: TopStockAPI) {
        self.networking = networking
        self.timeFrame = .oneHourPeriod
    }
    
    /// FIXME: Get this per day with some pagination after implementing scrolling chart.
    func getHistoricalBars() async {
        do {
            let historicalBars: HistoricalBars = try await self.networking.retrieveData(for: .historicalBars("AAPL", .OneHour, "2026-02-26T00:00:00Z"))
            
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
                guard let dateTime = candlestick.timestamp,
                        let timeFrameValue = Utilities.formattedTime(for: candlestick.timestamp, timeFrame: timeFrame) else {
                    return nil
                }
                
                return GraphableCandleStick(id: "\(timeFrameValue)",
                                            time: timeFrameValue,
                                            closePrice: candlestick.closePrice)
            }
            
            self.candlesticks = candlesticks
        }
    }
}
