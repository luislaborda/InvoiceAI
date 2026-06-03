import Foundation

protocol PDFService {
    func generateProposalPDF(_ proposal: Proposal, businessProfile: BusinessProfile) async throws -> Data
    func generateInvoicePDF(_ invoice: Invoice, businessProfile: BusinessProfile) async throws -> Data
}
