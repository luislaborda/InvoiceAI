import SwiftUI

struct BusinessProfileSetupView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Text("Your Business")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("This information appears on your proposals and invoices.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 40)

                // Logo placeholder
                VStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .fill(.gray.opacity(0.15))
                            .frame(width: 80, height: 80)
                        Image(systemName: "building.2")
                            .font(.title)
                            .foregroundStyle(.gray)
                    }
                    Text("Logo coming soon")
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                }

                VStack(spacing: 16) {
                    FormField(label: "Company Name", text: $viewModel.companyName, placeholder: "Mike's Handyman Services")
                    FormField(label: "Owner Name", text: $viewModel.ownerName, placeholder: "Mike Johnson")
                    FormField(label: "Phone Number", text: $viewModel.phone, placeholder: "(555) 000-1234", keyboard: .phonePad)
                    FormField(label: "Email", text: $viewModel.businessEmail, placeholder: "mike@example.com", keyboard: .emailAddress)
                    FormField(label: "Website", text: $viewModel.website, placeholder: "www.example.com (optional)", keyboard: .URL)
                    FormField(label: "Business Address", text: $viewModel.address, placeholder: "456 Main Street, Springfield")
                    FormField(label: "License Number", text: $viewModel.licenseNumber, placeholder: "Optional")
                }
                .padding(.horizontal, 24)

                Button(action: viewModel.advance) {
                    Text("Continue")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.canSaveBusinessProfile ? .blue : .gray.opacity(0.3))
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .disabled(!viewModel.canSaveBusinessProfile)
                .padding(.horizontal, 24)
                .padding(.top, 8)

                Spacer(minLength: 40)
            }
        }
        .scrollDismissesKeyboard(.interactively)
    }
}

#Preview {
    BusinessProfileSetupView(viewModel: OnboardingViewModel(authService: MockAuthService(), appState: AppState()))
}
