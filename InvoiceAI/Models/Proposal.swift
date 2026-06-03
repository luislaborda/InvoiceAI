import Foundation

struct Proposal: Identifiable, Codable {
    let id: UUID
    var documentNumber: String
    var customer: Customer
    var jobLocation: JobLocation?
    var lineItems: [LineItem]
    var discount: Discount?
    var taxSettings: TaxSettings
    var notes: String?
    var status: DocumentStatus
    var createdAt: Date
    var updatedAt: Date
    var sentAt: Date?

    init(
        id: UUID = UUID(),
        documentNumber: String,
        customer: Customer,
        jobLocation: JobLocation? = nil,
        lineItems: [LineItem] = [],
        discount: Discount? = nil,
        taxSettings: TaxSettings = .defaultTax,
        notes: String? = nil,
        status: DocumentStatus = .draft,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        sentAt: Date? = nil
    ) {
        self.id = id
        self.documentNumber = documentNumber
        self.customer = customer
        self.jobLocation = jobLocation
        self.lineItems = lineItems
        self.discount = discount
        self.taxSettings = taxSettings
        self.notes = notes
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.sentAt = sentAt
    }

    var subtotal: MoneyAmount {
        lineItems.reduce(MoneyAmount.zero) { $0 + $1.total }
    }

    var discountAmount: MoneyAmount {
        discount?.discountAmount(on: subtotal) ?? .zero
    }

    var taxableAmount: MoneyAmount {
        MoneyAmount.usd(subtotal.amount - discountAmount.amount)
    }

    var taxAmount: MoneyAmount {
        taxSettings.taxAmount(on: taxableAmount)
    }

    var total: MoneyAmount {
        MoneyAmount.usd(taxableAmount.amount + taxAmount.amount)
    }

    var laborItems: [LineItem] {
        lineItems.filter { $0.category == .labor }
    }

    var materialItems: [LineItem] {
        lineItems.filter { $0.category == .materials }
    }

    var feeItems: [LineItem] {
        lineItems.filter { $0.category == .fee || $0.category == .miscellaneous }
    }
}
