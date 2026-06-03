import Foundation

enum SubscriptionPlan: String, Codable, CaseIterable, Identifiable {
    case starter
    case pro
    case business

    var id: String { rawValue }

    var productIdentifier: String {
        switch self {
        case .starter: return "com.app.handymanai.starter.monthly"
        case .pro: return "com.app.handymanai.pro.monthly"
        case .business: return "com.app.handymanai.business.monthly"
        }
    }

    var monthlyGenerationLimit: Int {
        switch self {
        case .starter: return 50
        case .pro: return 250
        case .business: return 1_000
        }
    }

    var displayName: String {
        switch self {
        case .starter: return "Starter"
        case .pro: return "Pro"
        case .business: return "Business"
        }
    }

    var tagline: String {
        switch self {
        case .starter: return "For solo handymen getting started"
        case .pro: return "For busy contractors"
        case .business: return "For growing teams"
        }
    }
}
