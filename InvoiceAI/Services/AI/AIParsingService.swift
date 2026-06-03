import Foundation

protocol AIParsingService {
    func parseVoiceInput(_ text: String) async throws -> Proposal
}

enum AIParsingError: LocalizedError {
    case subscriptionRequired
    case usageLimitReached
    case parsingFailed(String)
    case networkError(String)

    var errorDescription: String? {
        switch self {
        case .subscriptionRequired:
            return "An active subscription is required to use AI features."
        case .usageLimitReached:
            return "You've reached your monthly AI generation limit. Upgrade your plan for more."
        case .parsingFailed(let reason):
            return "Could not understand the request: \(reason)"
        case .networkError(let reason):
            return "Network error: \(reason)"
        }
    }
}
