import Foundation

enum DocumentType: String, Codable, CaseIterable, Identifiable {
    case proposal
    case invoice

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .proposal: return "Proposal"
        case .invoice: return "Invoice"
        }
    }
}
