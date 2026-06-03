import Foundation

struct UsageMeter: Codable {
    var currentPeriodStart: Date
    var currentPeriodEnd: Date
    var generationsUsed: Int
    var generationsLimit: Int

    init(
        currentPeriodStart: Date = Date(),
        currentPeriodEnd: Date = Calendar.current.date(byAdding: .month, value: 1, to: Date()) ?? Date(),
        generationsUsed: Int = 0,
        generationsLimit: Int = 50
    ) {
        self.currentPeriodStart = currentPeriodStart
        self.currentPeriodEnd = currentPeriodEnd
        self.generationsUsed = generationsUsed
        self.generationsLimit = generationsLimit
    }

    var generationsRemaining: Int {
        max(0, generationsLimit - generationsUsed)
    }

    var usagePercentage: Double {
        guard generationsLimit > 0 else { return 1.0 }
        return Double(generationsUsed) / Double(generationsLimit)
    }

    var isAtLimit: Bool {
        generationsUsed >= generationsLimit
    }

    var isPeriodExpired: Bool {
        Date() > currentPeriodEnd
    }

    mutating func recordGeneration() {
        generationsUsed += 1
    }

    mutating func resetForNewPeriod(limit: Int) {
        currentPeriodStart = Date()
        currentPeriodEnd = Calendar.current.date(byAdding: .month, value: 1, to: Date()) ?? Date()
        generationsUsed = 0
        generationsLimit = limit
    }

    static func forPlan(_ plan: SubscriptionPlan) -> UsageMeter {
        UsageMeter(generationsLimit: plan.monthlyGenerationLimit)
    }
}
