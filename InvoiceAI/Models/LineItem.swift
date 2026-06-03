import Foundation

struct LineItem: Identifiable, Codable, Equatable {
    let id: UUID
    var description: String
    var category: LineItemCategory
    var quantity: Double
    var unitPrice: MoneyAmount
    var hours: Double?

    init(
        id: UUID = UUID(),
        description: String,
        category: LineItemCategory,
        quantity: Double = 1,
        unitPrice: MoneyAmount,
        hours: Double? = nil
    ) {
        self.id = id
        self.description = description
        self.category = category
        self.quantity = quantity
        self.unitPrice = unitPrice
        self.hours = hours
    }

    var total: MoneyAmount {
        unitPrice * Decimal(quantity)
    }
}

enum LineItemCategory: String, Codable, CaseIterable, Identifiable {
    case labor
    case materials
    case fee
    case miscellaneous

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .labor: return "Labor"
        case .materials: return "Materials"
        case .fee: return "Fee"
        case .miscellaneous: return "Miscellaneous"
        }
    }
}
