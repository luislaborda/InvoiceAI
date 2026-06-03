import SwiftUI

struct PaymentTermsEditView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.dismiss) private var dismiss

    @State private var selectedOption: PaymentTermsOption = .dueUponReceipt
    @State private var customDaysText = ""

    var body: some View {
        List {
            Section {
                ForEach(PaymentTermsOption.allCases) { option in
                    Button {
                        withAnimation { selectedOption = option }
                    } label: {
                        HStack {
                            Text(option.displayName)
                                .foregroundStyle(.primary)
                            Spacer()
                            if selectedOption == option {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.blue)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                }
            } header: {
                Text("Default payment terms for invoices")
            }

            if selectedOption == .custom {
                Section("Custom") {
                    HStack {
                        Text("Days until due")
                        Spacer()
                        TextField("45", text: $customDaysText)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 80)
                    }
                }
            }
        }
        .navigationTitle("Payment Terms")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    save()
                    dismiss()
                }
            }
        }
        .onAppear { loadSettings() }
    }

    private func loadSettings() {
        guard let profile = appState.businessProfile else { return }
        switch profile.defaultPaymentTerms {
        case .dueUponReceipt: selectedOption = .dueUponReceipt
        case .net7: selectedOption = .net7
        case .net15: selectedOption = .net15
        case .net30: selectedOption = .net30
        case .custom(let days):
            selectedOption = .custom
            customDaysText = "\(days)"
        }
    }

    private func save() {
        guard var profile = appState.businessProfile else { return }
        profile.defaultPaymentTerms = selectedOption.toPaymentTerms(customDays: Int(customDaysText) ?? 0)
        appState.businessProfile = profile
    }
}

#Preview {
    NavigationStack {
        PaymentTermsEditView()
    }
    .environmentObject(AppState())
}
