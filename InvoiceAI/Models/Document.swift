import Foundation

struct Document: Identifiable, Codable {
    let id: UUID
    var documentType: DocumentType
    var documentNumber: String
    var customerName: String
    var jobAddress: String?
    var jobDescription: String?
    var status: DocumentStatus
    var total: MoneyAmount
    var createdAt: Date
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        documentType: DocumentType,
        documentNumber: String,
        customerName: String,
        jobAddress: String? = nil,
        jobDescription: String? = nil,
        status: DocumentStatus = .draft,
        total: MoneyAmount = .zero,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.documentType = documentType
        self.documentNumber = documentNumber
        self.customerName = customerName
        self.jobAddress = jobAddress
        self.jobDescription = jobDescription
        self.status = status
        self.total = total
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    static func fromProposal(_ proposal: Proposal) -> Document {
        Document(
            id: proposal.id,
            documentType: .proposal,
            documentNumber: proposal.documentNumber,
            customerName: proposal.customer.name,
            jobAddress: proposal.jobLocation?.address,
            jobDescription: proposal.lineItems.first?.description,
            status: proposal.status,
            total: proposal.total,
            createdAt: proposal.createdAt,
            updatedAt: proposal.updatedAt
        )
    }

    static func fromInvoice(_ invoice: Invoice) -> Document {
        Document(
            id: invoice.id,
            documentType: .invoice,
            documentNumber: invoice.documentNumber,
            customerName: invoice.customer.name,
            jobAddress: invoice.jobLocation?.address,
            jobDescription: invoice.lineItems.first?.description,
            status: invoice.status,
            total: invoice.total,
            createdAt: invoice.createdAt,
            updatedAt: invoice.updatedAt
        )
    }
}
