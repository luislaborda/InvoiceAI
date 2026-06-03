import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var appState: AppState

    let authService: AuthService

    var body: some View {
        Group {
            if appState.hasCompletedOnboarding {
                MainTabView()
            } else {
                OnboardingContainerView(authService: authService, appState: appState)
            }
        }
        .animation(.easeInOut, value: appState.hasCompletedOnboarding)
    }
}

#Preview {
    ContentView(authService: MockAuthService())
        .environmentObject(AppState())
}
