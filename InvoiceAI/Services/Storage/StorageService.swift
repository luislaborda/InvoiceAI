import Foundation

protocol StorageService {
    func saveProposal(_ proposal: Proposal) async throws
    func loadProposal(id: UUID) async throws -> Proposal?
    func listProposals() async throws -> [Proposal]
    func deleteProposal(id: UUID) async throws

    func saveInvoice(_ invoice: Invoice) async throws
    func loadInvoice(id: UUID) async throws -> Invoice?
    func listInvoices() async throws -> [Invoice]
    func deleteInvoice(id: UUID) async throws

    func saveBusinessProfile(_ profile: BusinessProfile) async throws
    func loadBusinessProfile() async throws -> BusinessProfile?

    func searchDocuments(query: String) async throws -> [Document]
}
