import SwiftUI

@main
struct InvoiceAIApp: App {
    @StateObject private var appState = AppState()

    private let authService: AuthService = MockAuthService()

    var body: some Scene {
        WindowGroup {
            ContentView(authService: authService)
                .environmentObject(appState)
        }
    }
}
