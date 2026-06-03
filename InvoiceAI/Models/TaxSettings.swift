import Foundation

struct TaxSettings: Codable, Equatable {
    var rate: Decimal
    var label: String
    var isEnabled: Bool

    init(rate: Decimal, label: String = "Sales Tax", isEnabled: Bool = true) {
        self.rate = rate
        self.label = label
        self.isEnabled = isEnabled
    }

    var ratePercentage: Decimal {
        rate * 100
    }

    var formattedRate: String {
        "\(ratePercentage)%"
    }

    func taxAmount(on subtotal: MoneyAmount) -> MoneyAmount {
        guard isEnabled else { return .zero }
        return subtotal * rate
    }

    static let defaultTax = TaxSettings(rate: 0.08, label: "Sales Tax")
    static let noTax = TaxSettings(rate: 0, label: "No Tax", isEnabled: false)
}
