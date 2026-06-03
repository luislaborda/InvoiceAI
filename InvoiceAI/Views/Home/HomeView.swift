import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                Spacer()

                VStack(spacing: 12) {
                    Image(systemName: "mic.circle.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(.blue)

                    Text("Ready to create your first proposal.")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)

                    if let profile = appState.businessProfile {
                        Text(profile.companyName)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }

                Button {} label: {
                    Label("Create by Voice", systemImage: "mic.fill")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.gray.opacity(0.2))
                        .foregroundStyle(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .disabled(true)
                .padding(.horizontal, 24)

                Text("Voice creation is coming in the next update.")
                    .font(.caption)
                    .foregroundStyle(.tertiary)

                Spacer()

                // Usage summary
                if appState.subscriptionStatus.isActive {
                    HStack {
                        Image(systemName: "sparkles")
                            .foregroundStyle(.blue)
                        Text("\(appState.usageMeter.generationsRemaining) AI generations remaining")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(appState.subscriptionStatus.plan.displayName)
                            .font(.caption)
                            .fontWeight(.medium)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(.blue.opacity(0.1))
                            .foregroundStyle(.blue)
                            .clipShape(Capsule())
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 8)
                }
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AppState())
}
