import Foundation

struct MoneyAmount: Codable, Equatable, Hashable {
    var amount: Decimal
    var currency: String

    init(amount: Decimal, currency: String = "USD") {
        self.amount = amount
        self.currency = currency
    }

    static let zero = MoneyAmount(amount: 0)

    static func usd(_ amount: Decimal) -> MoneyAmount {
        MoneyAmount(amount: amount, currency: "USD")
    }

    var formatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        return formatter.string(from: amount as NSDecimalNumber) ?? "$0.00"
    }
}

extension MoneyAmount {
    static func + (lhs: MoneyAmount, rhs: MoneyAmount) -> MoneyAmount {
        MoneyAmount(amount: lhs.amount + rhs.amount, currency: lhs.currency)
    }

    static func * (lhs: MoneyAmount, rhs: Decimal) -> MoneyAmount {
        MoneyAmount(amount: lhs.amount * rhs, currency: lhs.currency)
    }
}
