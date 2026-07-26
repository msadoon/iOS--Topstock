import Testing
import Foundation
@testable import AdvisorDashboard

struct TopStockNetworkingTests {
    /**
        FIXME: Normally I would make a MockNetworking struct to run against tests, but in this project the networking singleton doesn't hit a real network.
     */
    
    @Test func allAdvisors() async throws {
        let allAdvisors: [Advisor] = try await Networking.shared.retrieveData(for: .advisors)
        
        #expect(allAdvisors.count == 5)
        
        let sampleAdvisor = allAdvisors[3]
        
        #expect(sampleAdvisor.name.hasPrefix("Isabella Cruz"))
        #expect(sampleAdvisor.portfolioSummary.count == 2)
        let _ = try #require(sampleAdvisor.profilePictureUrl?.absoluteString)
        let sampleAdvisorPreview = try #require(sampleAdvisor.portfolioSummary.first)
        
        #expect(sampleAdvisorPreview.name.hasPrefix("Mia Patel"))
        #expect(sampleAdvisorPreview.totalAssets == 32096.30)
    }
    
    @Test func accountsForAdvisor() async throws {
        let accountsForAdvisor: [Account] = try await Networking.shared.retrieveData(for: .accounts("k4d3"))
        
        #expect(accountsForAdvisor.count == 2)
        
        let sampleAccount = accountsForAdvisor[0]
        
        #expect(sampleAccount.name.hasPrefix("Nathan Cole"))
        
        let totalAssets = sampleAccount.holdings.reduce(0.0) { partialResult, holding in
            return partialResult + (Double(holding.units) * holding.unitPrice)
        }
        
        #expect(totalAssets == 16200.00)
    }
    
    @Test func securityForSymbol() async throws {
        let securityForSymbol: [Security] = try await Networking.shared.retrieveData(for: .ticker("GRTHX"))
        
        #expect(securityForSymbol.count == 1)
        
        let sampleSecurity = securityForSymbol[0]
        
        #expect(sampleSecurity.name == "Green Growth Equity Fund")
        let dateAvailable = try #require(sampleSecurity.dateAdded)
        
        let dateComponents = Calendar.current.dateComponents ([.month, .day, .year], from: dateAvailable)
        
        #expect(dateComponents.month == 3)
        #expect(dateComponents.day == 2)
        #expect(dateComponents.year == 2015)
        
        #expect(sampleSecurity.exchange == .NASDAQ)
        
        let _ = try #require(sampleSecurity.snapshots[.sevenDay]?.absoluteString)
        let _ = try #require(sampleSecurity.snapshots[.sixMonth]?.absoluteString)
        let _ = try #require(sampleSecurity.snapshots[.oneYear]?.absoluteString)
    }
}
