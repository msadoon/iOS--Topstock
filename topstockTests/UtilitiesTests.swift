import Testing
import Foundation
@testable import topstock

struct UtilitiesTests {
    static private let utcDate = "2025-12-19T23:02:25Z"
    static private let nonUTCDate = "1969-12-31A23:59:59Z"
    static private let exampleFilename = "Movers"
    
    @Test("Successful UTC datetime to UTC date conversion.", arguments: [utcDate]) func successfulDateConversionToUTC(datetime: String) async throws {
        let conversionResultDate = try #require(Utilities.validUTCDate(from: datetime))
        
        let conversionResultDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: conversionResultDate)
        
        #expect(conversionResultDateComponents.day == 19)
        #expect(conversionResultDateComponents.month == 12)
        #expect(conversionResultDateComponents.year == 2025)
    }
    
    @Test("Failure non-UTC datetime to UTC conversion.", arguments: [nonUTCDate]) func failureDateConversionToUTC(datetime: String) async {
        let conversionResult = Utilities.validUTCDate(from: datetime)
        
        #expect(conversionResult == nil)
    }
}
