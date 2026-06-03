import Foundation

protocol AuthService {
    func currentUser() async -> UserAccount?
    func signIn(email: String, password: String) async throws -> UserAccount
    func signUp(email: String, password: String, displayName: String) async throws -> UserAccount
    func signOut() async throws
}
