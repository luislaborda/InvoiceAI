import SwiftUI

struct TaxSettingsEditView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.dismiss) private var dismiss

    @State private var taxRateText = ""
    @State private var taxEnabled = true

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Default Tax Rate (%)")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    HStack {
                        TextField("8", text: $taxRateText)
                            .keyboardType(.decimalPad)
                            .padding()
                            .background(.gray.opacity(0.08))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        Text("%")
                            .font(.title3)
                            .foregroundStyle(.secondary)
                    }
                }

                Toggle("Apply tax by default", isOn: $taxEnabled)
                    .tint(.blue)

                VStack(spacing: 8) {
                    Image(systemName: "info.circle")
                        .foregroundStyle(.blue)
                    Text("This rate will be applied to all new proposals and invoices. You can always adjust the tax on individual documents.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 8)
            }
            .padding(24)
        }
        .scrollDismissesKeyboard(.interactively)
        .navigationTitle("Tax Settings")
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
        let percentage = profile.defaultTaxSettings.ratePercentage
        taxRateText = "\(percentage)"
        taxEnabled = profile.defaultTaxSettings.isEnabled
    }

    private func save() {
        guard var profile = appState.businessProfile else { return }
        let rate = Decimal(string: taxRateText) ?? 8
        profile.defaultTaxSettings = TaxSettings(
            rate: rate / 100,
            label: "Sales Tax",
            isEnabled: taxEnabled
        )
        appState.businessProfile = profile
    }
}

#Preview {
    NavigationStack {
        TaxSettingsEditView()
    }
    .environmentObject(AppState())
}
