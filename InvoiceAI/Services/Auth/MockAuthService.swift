import Foundation

final class MockAuthService: AuthService {
    func currentUser() async -> UserAccount? {
        nil
    }

    func signIn(email: String, password: String) async throws -> UserAccount {
        try await Task.sleep(for: .milliseconds(500))
        return UserAccount(email: email, displayName: email.components(separatedBy: "@").first ?? "User")
    }

    func signUp(email: String, password: String, displayName: String) async throws -> UserAccount {
        try await Task.sleep(for: .milliseconds(500))
        return UserAccount(email: email, displayName: displayName)
    }

    func signOut() async throws {}
}
