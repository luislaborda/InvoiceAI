import Foundation

enum DocumentStatus: String, Codable, CaseIterable, Identifiable {
    case draft
    case sent
    case approved
    case invoiced
    case paid
    case cancelled

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .draft: return "Draft"
        case .sent: return "Sent"
        case .approved: return "Approved"
        case .invoiced: return "Invoiced"
        case .paid: return "Paid"
        case .cancelled: return "Cancelled"
        }
    }
}
