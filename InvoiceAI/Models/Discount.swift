import Foundation

struct Discount: Codable, Equatable {
    var type: DiscountType
    var value: Decimal
    var description: String?

    enum DiscountType: String, Codable, CaseIterable {
        case percentage
        case fixedAmount
    }

    func discountAmount(on subtotal: MoneyAmount) -> MoneyAmount {
        switch type {
        case .percentage:
            return subtotal * (value / 100)
        case .fixedAmount:
            return .usd(value)
        }
    }

    var formattedValue: String {
        switch type {
        case .percentage:
            return "\(value)%"
        case .fixedAmount:
            return MoneyAmount.usd(value).formatted
        }
    }

    static func percent(_ value: Decimal, description: String? = nil) -> Discount {
        Discount(type: .percentage, value: value, description: description)
    }

    static func fixed(_ amount: Decimal, description: String? = nil) -> Discount {
        Discount(type: .fixedAmount, value: amount, description: description)
    }
}
