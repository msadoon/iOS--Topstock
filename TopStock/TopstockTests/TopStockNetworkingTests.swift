import Testing
import Foundation
@testable import Topstock

struct TopStockNetworkingTests {
    private let networking = MockTopStockNetworking()
    
    @MainActor
    @Test func moversStocks() async throws {
        MockTopStockNetworking.expectedState = .moversStocks
        
        let movers: Movers = try await networking.retrieveData(for: .moversStocks)
        
        #expect(movers.gainers.count == 10)
        #expect(movers.losers.count == 10)
        
        let sampleSecurity = movers.losers[3]
        
        #expect(sampleSecurity.price == 0.0986)
        #expect(sampleSecurity.symbol == "VSTD")
        #expect(sampleSecurity.percentChange == -45.22)
        #expect(sampleSecurity.change == -0.0814)
    }
    
    @MainActor
    @Test func historicalBars() async throws {
        MockTopStockNetworking.expectedState = .historicalBars
        
        let historicalBars: HistoricalBars = try await networking.retrieveData(for: .historicalBars("AAPL", .OneHour, "2026-02-26T09:00:00Z"))
        
        #expect(historicalBars.bars.count == 16)
        
        let sampleCandleStickBar = historicalBars.bars[3]
        
        #expect(sampleCandleStickBar.numTrades == 213)
        #expect(sampleCandleStickBar.volume == 9240)
        #expect(sampleCandleStickBar.highPrice == 375.01)
        let timestampDate = try #require(sampleCandleStickBar.timestamp)
        let dateComponents = Calendar.current.dateComponents([.hour, .day, .month, .year], from: timestampDate)
        /** FIXME: Ensure we have a Utility to extract the 24 hour time.
        #expect(dateComponents.hour == 11)
         */
        #expect(dateComponents.day == 26)
        #expect(dateComponents.month == 2)
        #expect(dateComponents.year == 2026)
        #expect(sampleCandleStickBar.closePrice == 374.74)
        #expect(sampleCandleStickBar.openPrice == 374.9)
        #expect(sampleCandleStickBar.lowPrice == 374.7)
        #expect(sampleCandleStickBar.volumeWeightedAveragePrice == 374.82)
    }
}
