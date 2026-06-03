import Foundation

struct SubscriptionStatus: Codable {
    var plan: SubscriptionPlan
    var isActive: Bool
    var expiresAt: Date?
    var startedAt: Date?
    var autoRenews: Bool

    init(
        plan: SubscriptionPlan = .starter,
        isActive: Bool = false,
        expiresAt: Date? = nil,
        startedAt: Date? = nil,
        autoRenews: Bool = false
    ) {
        self.plan = plan
        self.isActive = isActive
        self.expiresAt = expiresAt
        self.startedAt = startedAt
        self.autoRenews = autoRenews
    }

    var isExpired: Bool {
        guard let expiresAt else { return !isActive }
        return expiresAt < Date()
    }

    var canUseAI: Bool {
        isActive && !isExpired
    }

    static let inactive = SubscriptionStatus()

    static func mockActive(plan: SubscriptionPlan = .pro) -> SubscriptionStatus {
        SubscriptionStatus(
            plan: plan,
            isActive: true,
            expiresAt: Calendar.current.date(byAdding: .month, value: 1, to: Date()),
            startedAt: Date(),
            autoRenews: true
        )
    }
}
