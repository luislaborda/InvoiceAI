import Foundation

struct Customer: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    var name: String
    var phone: String?
    var email: String?
    var address: String?
    var notes: String?

    init(
        id: UUID = UUID(),
        name: String,
        phone: String? = nil,
        email: String? = nil,
        address: String? = nil,
        notes: String? = nil
    ) {
        self.id = id
        self.name = name
        self.phone = phone
        self.email = email
        self.address = address
        self.notes = notes
    }
}
