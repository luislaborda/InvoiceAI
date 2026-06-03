import SwiftUI

struct TaxSettingsSetupView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Text("Tax Settings")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("Set your default tax rate. You can change it for each proposal or invoice later.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }
                .padding(.top, 40)

                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Default Tax Rate (%)")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        HStack {
                            TextField("8", text: $viewModel.taxRateText)
                                .keyboardType(.decimalPad)
                                .padding()
                                .background(.gray.opacity(0.08))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Text("%")
                                .font(.title3)
                                .foregroundStyle(.secondary)
                        }
                    }

                    Toggle("Apply tax by default", isOn: $viewModel.taxEnabled)
                        .tint(.blue)
                }
                .padding(.horizontal, 24)

                VStack(spacing: 8) {
                    Image(systemName: "info.circle")
                        .foregroundStyle(.blue)
                    Text("This rate will be applied to all new proposals and invoices. You can always adjust the tax on individual documents.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 32)
                .padding(.top, 8)

                Button(action: viewModel.advance) {
                    Text("Continue")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)

                Spacer(minLength: 40)
            }
        }
        .scrollDismissesKeyboard(.interactively)
    }
}

#Preview {
    TaxSettingsSetupView(viewModel: OnboardingViewModel(authService: MockAuthService(), appState: AppState()))
}
