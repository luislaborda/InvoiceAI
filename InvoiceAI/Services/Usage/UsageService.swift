import Foundation

protocol UsageService {
    func currentUsage() async -> UsageMeter
    func recordGeneration() async throws -> UsageMeter
    func canGenerate() async -> Bool
}
