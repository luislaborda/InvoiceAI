import Foundation

struct BusinessProfile: Identifiable, Codable {
    let id: UUID
    var companyName: String
    var ownerName: String
    var phone: String
    var email: String
    var website: String?
    var address: String
    var licenseNumber: String?
    var logoData: Data?
    var defaultTaxSettings: TaxSettings
    var defaultPaymentTerms: PaymentTerms
    var defaultProposalNotes: String?
    var defaultInvoiceNotes: String?

    init(
        id: UUID = UUID(),
        companyName: String,
        ownerName: String,
        phone: String,
        email: String,
        website: String? = nil,
        address: String,
        licenseNumber: String? = nil,
        logoData: Data? = nil,
        defaultTaxSettings: TaxSettings = .defaultTax,
        defaultPaymentTerms: PaymentTerms = .dueUponReceipt,
        defaultProposalNotes: String? = nil,
        defaultInvoiceNotes: String? = nil
    ) {
        self.id = id
        self.companyName = companyName
        self.ownerName = ownerName
        self.phone = phone
        self.email = email
        self.website = website
        self.address = address
        self.licenseNumber = licenseNumber
        self.logoData = logoData
        self.defaultTaxSettings = defaultTaxSettings
        self.defaultPaymentTerms = defaultPaymentTerms
        self.defaultProposalNotes = defaultProposalNotes
        self.defaultInvoiceNotes = defaultInvoiceNotes
    }
}
