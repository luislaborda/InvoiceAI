import Foundation

protocol SubscriptionService {
    func currentStatus() async -> SubscriptionStatus
    func purchase(plan: SubscriptionPlan) async throws -> SubscriptionStatus
    func restorePurchases() async throws -> SubscriptionStatus
}
