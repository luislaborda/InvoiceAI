import SwiftUI

struct PaymentTermsSetupView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Text("Payment Terms")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("Choose when your invoices are due by default.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }
                .padding(.top, 40)

                VStack(spacing: 0) {
                    ForEach(PaymentTermsOption.allCases) { option in
                        Button {
                            withAnimation { viewModel.selectedTermsOption = option }
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(option.displayName)
                                        .font(.body)
                                    if option == .dueUponReceipt {
                                        Text("Payment expected right away")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                Spacer()
                                if viewModel.selectedTermsOption == option {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(.blue)
                                        .font(.title3)
                                } else {
                                    Image(systemName: "circle")
                                        .foregroundStyle(.gray.opacity(0.4))
                                        .font(.title3)
                                }
                            }
                            .padding(.vertical, 14)
                            .padding(.horizontal, 16)
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)

                        if option != PaymentTermsOption.allCases.last {
                            Divider().padding(.leading, 16)
                        }
                    }
                }
                .background(.gray.opacity(0.06))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 24)

                if viewModel.selectedTermsOption == .custom {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Number of days")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        TextField("e.g. 45", text: $viewModel.customDaysText)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(.gray.opacity(0.08))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.horizontal, 24)
                    .transition(.opacity.combined(with: .move(edge: .top)))
                }

                Button(action: viewModel.completeOnboarding) {
                    Text("Finish Setup")
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
    PaymentTermsSetupView(viewModel: OnboardingViewModel(authService: MockAuthService(), appState: AppState()))
}
