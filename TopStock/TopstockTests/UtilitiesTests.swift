import Testing
import Foundation
@testable import Topstock

struct UtilitiesTests {
    static private let utcDate = "2025-12-19T23:02:25Z"
    static private let nonUTCDate = "1969-12-31A23:59:59Z"
    static private let exampleFilename = "Movers"
    static private let exampleSecurity = Security(symbol: "VSTD",
                                                  percentChange: -45.62,
                                                  change: -0.0814,
                                                  price: 1.0986)
    static private let mondayDate = "1996-02-19T17:43:31Z"
    static private let sundayDate = "1996-02-18T17:43:31Z"
    static private let saturdayDate = "1996-02-17T17:43:31Z"
    static private let fridayDate = "1996-02-16T17:43:31Z"
    static private let thursdayDate = "1996-02-15T17:43:31Z"
    
    @MainActor
    @Test("Successful UTC datetime to UTC date conversion.", arguments: [utcDate])
    func successfulDateConversionToUTC(datetime: String) async throws {
        let conversionResultDate = try #require( Utilities.validUTCDate(from: datetime))
        
        let conversionResultDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: conversionResultDate)
        
        #expect(conversionResultDateComponents.day == 19)
        #expect(conversionResultDateComponents.month == 12)
        #expect(conversionResultDateComponents.year == 2025)
    }
    
    @Test("Failure non-UTC datetime to UTC conversion.", arguments: [nonUTCDate])
    func failureDateConversionToUTC(datetime: String) async {
        let conversionResult = await Utilities.validUTCDate(from: datetime)
        
        #expect(conversionResult == nil)
    }
    
    @Test("Ensure dollar change gets formatted for numerical accuracy.", arguments: [UtilitiesTests.exampleSecurity])
    func formatDollarChange(for security: Security) {
        let formattedChange = Utilities.formattedDollarChange(for: security)
        #expect(formattedChange == "$-0.08")
    }
    
    @Test("Ensure percent change gets formatted for numerical accuracy.", arguments: [UtilitiesTests.exampleSecurity])
    func formatPercentChange(for security: Security) {
        let formattedChange = Utilities.formattedPercentChange(for: security)
        #expect(formattedChange == "-45%")
    }
    
    @Test("Ensure second last weekday can be returned from a weekday/weekend date.", arguments: [UtilitiesTests.mondayDate,
                                                                                      UtilitiesTests.sundayDate,
                                                                                      UtilitiesTests.saturdayDate])
    func lastWeekday(from dateValue: String) async throws {
        let submittedUTCDate = try #require(await Utilities.validUTCDate(from: dateValue))
        let dateText = await Utilities.lastWeekDay(from: submittedUTCDate)
        
        #expect(dateText == UtilitiesTests.fridayDate)
    }
    
    @Test("Ensure second last weekday can be returned from weekday date", arguments: [UtilitiesTests.fridayDate])
    func lastWeekdayFromAnotherWeekday(from dateValue: String) async throws {
        let submittedUTCDate = try #require(await Utilities.validUTCDate(from: dateValue))
        let dateText = await Utilities.lastWeekDay(from: submittedUTCDate)
        
        #expect(dateText == UtilitiesTests.thursdayDate)
    }
    
    @Test("Ensure time frames for date are returned.", arguments: [(UtilitiesTests.fridayDate, TopStockAPIEndpoint.HistoricalBarTimeFrame.FiveMin), (UtilitiesTests.fridayDate, TopStockAPIEndpoint.HistoricalBarTimeFrame.OneHour)])
    func timeFrames(from dateValue: String,
                    for timeFrame: TopStockAPIEndpoint.HistoricalBarTimeFrame) async throws {
        let submittedUTCDate = try #require(await Utilities.validUTCDate(from: dateValue))
        let timeFrameText = await Utilities.formattedTime(for: submittedUTCDate,
                                                          timeFrame: timeFrame)
        
        switch timeFrame {
        case .FiveMin:
            #expect(timeFrameText == 43)
        case .OneHour:
            #expect(timeFrameText == 17)
        }
    }
}
