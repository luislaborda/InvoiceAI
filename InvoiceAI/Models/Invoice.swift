import Foundation

struct Invoice: Identifiable, Codable {
    let id: UUID
    var documentNumber: String
    var proposalId: UUID?
    var customer: Customer
    var jobLocation: JobLocation?
    var lineItems: [LineItem]
    var discount: Discount?
    var taxSettings: TaxSettings
    var paymentTerms: PaymentTerms
    var notes: String?
    var status: DocumentStatus
    var dueDate: Date?
    var createdAt: Date
    var updatedAt: Date
    var sentAt: Date?
    var paidAt: Date?

    init(
        id: UUID = UUID(),
        documentNumber: String,
        proposalId: UUID? = nil,
        customer: Customer,
        jobLocation: JobLocation? = nil,
        lineItems: [LineItem] = [],
        discount: Discount? = nil,
        taxSettings: TaxSettings = .defaultTax,
        paymentTerms: PaymentTerms = .dueUponReceipt,
        notes: String? = nil,
        status: DocumentStatus = .draft,
        dueDate: Date? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        sentAt: Date? = nil,
        paidAt: Date? = nil
    ) {
        self.id = id
        self.documentNumber = documentNumber
        self.proposalId = proposalId
        self.customer = customer
        self.jobLocation = jobLocation
        self.lineItems = lineItems
        self.discount = discount
        self.taxSettings = taxSettings
        self.paymentTerms = paymentTerms
        self.notes = notes
        self.status = status
        self.dueDate = dueDate
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.sentAt = sentAt
        self.paidAt = paidAt
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

    static func fromProposal(_ proposal: Proposal, invoiceNumber: String, paymentTerms: PaymentTerms = .dueUponReceipt) -> Invoice {
        let invoice = Invoice(
            documentNumber: invoiceNumber,
            proposalId: proposal.id,
            customer: proposal.customer,
            jobLocation: proposal.jobLocation,
            lineItems: proposal.lineItems,
            discount: proposal.discount,
            taxSettings: proposal.taxSettings,
            paymentTerms: paymentTerms,
            notes: proposal.notes,
            dueDate: paymentTerms.dueDate(from: Date())
        )
        return invoice
    }
}
