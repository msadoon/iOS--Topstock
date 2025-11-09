import Testing
import Foundation
@testable import AdvisorDashboard

struct AdvisorDashboardSerializationTests {
    @Test func parseSecurities() async throws {
        let allSecurities: [Security] = Utilities.shared.loadJson(filename: "Securities")
        #expect(allSecurities.count == 13)
        
        let sampleSecurity = allSecurities[6]
        #expect(sampleSecurity.ticker == "ZNGFX")
        #expect(sampleSecurity.name == "Zenith Growth Opportunities")
        
        let dateAvailable = try #require(sampleSecurity.dateAdded)
        
        let dateComponents = Calendar.current.dateComponents ([.month, .day, .year], from: dateAvailable)
        
        #expect(dateComponents.month == 2)
        #expect(dateComponents.day == 14)
        #expect(dateComponents.year == 2019)
        
        #expect(sampleSecurity.exchange == .NASDAQ)
        
        let _ = try #require(sampleSecurity.snapshots[.sevenDay]?.absoluteString)
        let _ = try #require(sampleSecurity.snapshots[.sixMonth]?.absoluteString)
        let _ = try #require(sampleSecurity.snapshots[.oneYear]?.absoluteString)
    }
    
    @Test func parseAccounts() async throws {
        let allAccounts: [Account] = Utilities.shared.loadJson(filename: "Accounts")
        
        #expect(allAccounts.count == 9)
        
        let sampleAccount = allAccounts[2]
        #expect(sampleAccount.name.hasPrefix("Mia Patel"))
        #expect(sampleAccount.number == "77120384")
        #expect(sampleAccount.custodian == "Fidelity")
        
        #expect(sampleAccount.holdings.count == 2)
        
        let sampleHolding = try #require(sampleAccount.holdings.first)
        
        #expect(sampleHolding.ticker == "ZNGFX")
        #expect(sampleHolding.units == 190)
        #expect(sampleHolding.unitPrice == 110.37)
    }
    
    @Test func parseAdvisors() async throws {
        let allAdvisors: [Advisor] = Utilities.shared.loadJson(filename: "Advisors")
        
        #expect(allAdvisors.count == 5)
        
        let sampleAdvisor = allAdvisors[3]
        
        #expect(sampleAdvisor.name.hasPrefix("Isabella Cruz"))
        #expect(sampleAdvisor.portfolioSummary.count == 2)
        let _ = try #require(sampleAdvisor.profilePictureUrl?.absoluteString)
        
        let sampleAdvisorPreview = try #require(sampleAdvisor.portfolioSummary.first)
        
        #expect(sampleAdvisorPreview.name.hasPrefix("Mia Patel"))
        #expect(sampleAdvisorPreview.totalAssets == 32096.30)
    }
}
