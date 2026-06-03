import Foundation

struct UserAccount: Identifiable, Codable {
    let id: UUID
    var email: String
    var displayName: String
    var createdAt: Date
    var lastLoginAt: Date?

    init(
        id: UUID = UUID(),
        email: String,
        displayName: String,
        createdAt: Date = Date(),
        lastLoginAt: Date? = nil
    ) {
        self.id = id
        self.email = email
        self.displayName = displayName
        self.createdAt = createdAt
        self.lastLoginAt = lastLoginAt
    }
}
