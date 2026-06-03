import Foundation

enum PaymentTerms: Codable, Equatable {
    case dueUponReceipt
    case net7
    case net15
    case net30
    case custom(days: Int)

    var displayName: String {
        switch self {
        case .dueUponReceipt: return "Due Upon Receipt"
        case .net7: return "Net 7"
        case .net15: return "Net 15"
        case .net30: return "Net 30"
        case .custom(let days): return "Net \(days)"
        }
    }

    var days: Int {
        switch self {
        case .dueUponReceipt: return 0
        case .net7: return 7
        case .net15: return 15
        case .net30: return 30
        case .custom(let days): return days
        }
    }

    func dueDate(from issueDate: Date) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: issueDate) ?? issueDate
    }
}
