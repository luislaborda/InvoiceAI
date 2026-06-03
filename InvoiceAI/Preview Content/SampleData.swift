import Foundation

enum SampleData {

    // MARK: - Customers

    static let customerMaria = Customer(
        name: "Maria Jose Albanero",
        phone: "(555) 123-4567",
        email: "maria@example.com",
        address: "742 Evergreen Terrace, Springfield"
    )

    static let customerJohn = Customer(
        name: "John Patterson",
        phone: "(555) 987-6543",
        email: "john.p@example.com",
        address: "1100 Oak Drive, Riverside"
    )

    // MARK: - Job Locations

    static let locationMaria = JobLocation(
        address: "742 Evergreen Terrace, Springfield",
        latitude: 37.7749,
        longitude: -122.4194
    )

    static let locationJohn = JobLocation(
        address: "1100 Oak Drive, Riverside",
        latitude: 33.9533,
        longitude: -117.3962
    )

    // MARK: - Business Profile

    static let businessProfile = BusinessProfile(
        companyName: "Mike's Handyman Services",
        ownerName: "Mike Johnson",
        phone: "(555) 000-1234",
        email: "mike@mikeshandyman.com",
        website: "www.mikeshandyman.com",
        address: "456 Main Street, Springfield",
        licenseNumber: "HIC-123456",
        defaultTaxSettings: TaxSettings(rate: 0.08, label: "Sales Tax"),
        defaultPaymentTerms: .net30,
        defaultProposalNotes: "This proposal is valid for 30 days.",
        defaultInvoiceNotes: "Thank you for your business!"
    )

    // MARK: - User Account

    static let userAccount = UserAccount(
        email: "mike@mikeshandyman.com",
        displayName: "Mike Johnson"
    )

    // MARK: - Subscription

    static let activeSubscription = SubscriptionStatus.mockActive(plan: .pro)

    static let usageMeter = UsageMeter(
        generationsUsed: 23,
        generationsLimit: 250
    )

    // MARK: - Line Items (from spec sample command)

    static let lineItemFaucet = LineItem(
        description: "Replace kitchen faucet",
        category: .labor,
        quantity: 1,
        unitPrice: .usd(50),
        hours: 1
    )

    static let lineItemLeak = LineItem(
        description: "Fix bathroom leak",
        category: .labor,
        quantity: 1,
        unitPrice: .usd(250),
        hours: 3
    )

    static let lineItemMaterials = LineItem(
        description: "Pipes, sealers, and miscellaneous",
        category: .materials,
        quantity: 1,
        unitPrice: .usd(250)
    )

    static let lineItemMiscFee = LineItem(
        description: "Miscellaneous fee",
        category: .miscellaneous,
        quantity: 1,
        unitPrice: .usd(100)
    )

    // MARK: - Proposal (matches spec sample command)

    static let sampleProposal = Proposal(
        documentNumber: "P-2026-001",
        customer: customerMaria,
        jobLocation: locationMaria,
        lineItems: [lineItemFaucet, lineItemLeak, lineItemMaterials, lineItemMiscFee],
        discount: .percent(15, description: "Discount"),
        taxSettings: TaxSettings(rate: 0.08, label: "Sales Tax"),
        notes: "This proposal is valid for 30 days.",
        status: .draft
    )

    // MARK: - Invoice (generated from proposal)

    static let sampleInvoice: Invoice = {
        var invoice = Invoice.fromProposal(sampleProposal, invoiceNumber: "INV-2026-001", paymentTerms: .net30)
        invoice.notes = "Thank you for your business!"
        return invoice
    }()

    // MARK: - Document list for archive preview

    static let documents: [Document] = [
        Document.fromProposal(sampleProposal),
        Document(
            documentType: .proposal,
            documentNumber: "P-2026-002",
            customerName: "John Patterson",
            jobAddress: "1100 Oak Drive, Riverside",
            jobDescription: "Install ceiling fan",
            status: .sent,
            total: .usd(350),
            createdAt: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date()
        ),
        Document(
            documentType: .invoice,
            documentNumber: "INV-2026-001",
            customerName: "Maria Jose Albanero",
            jobAddress: "742 Evergreen Terrace, Springfield",
            jobDescription: "Replace kitchen faucet",
            status: .paid,
            total: .usd(552.50),
            createdAt: Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        ),
        Document(
            documentType: .proposal,
            documentNumber: "P-2026-003",
            customerName: "Sarah Williams",
            jobAddress: "220 Pine Lane, Oakville",
            jobDescription: "Deck repair and staining",
            status: .approved,
            total: .usd(2_800),
            createdAt: Calendar.current.date(byAdding: .day, value: -14, to: Date()) ?? Date()
        ),
    ]
}
