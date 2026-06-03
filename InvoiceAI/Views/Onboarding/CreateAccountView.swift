import SwiftUI

struct CreateAccountView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Text("Create Your Account")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("Enter your name and email to get started.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 40)

                VStack(spacing: 16) {
                    FormField(label: "Your Name", text: $viewModel.name, placeholder: "Mike Johnson", keyboard: .default)
                    FormField(label: "Email", text: $viewModel.email, placeholder: "mike@example.com", keyboard: .emailAddress)
                    FormField(label: "Password", text: $viewModel.password, placeholder: "Create a password", isSecure: true)
                }
                .padding(.horizontal, 24)

                Button {
                    Task { await viewModel.createAccount() }
                } label: {
                    Group {
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("Continue")
                        }
                    }
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.canCreateAccount ? .blue : .gray.opacity(0.3))
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .disabled(!viewModel.canCreateAccount || viewModel.isLoading)
                .padding(.horizontal, 24)
                .padding(.top, 8)

                Spacer(minLength: 40)
            }
        }
        .scrollDismissesKeyboard(.interactively)
    }
}

#Preview {
    CreateAccountView(viewModel: OnboardingViewModel(authService: MockAuthService(), appState: AppState()))
}
