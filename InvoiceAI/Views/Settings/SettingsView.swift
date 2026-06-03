import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        NavigationStack {
            List {
                Section("Business") {
                    NavigationLink {
                        BusinessProfileEditView()
                    } label: {
                        SettingsRow(
                            icon: "building.2",
                            title: "Business Profile",
                            detail: appState.businessProfile?.companyName
                        )
                    }

                    NavigationLink {
                        TaxSettingsEditView()
                    } label: {
                        SettingsRow(
                            icon: "percent",
                            title: "Tax Rate",
                            detail: appState.businessProfile?.defaultTaxSettings.formattedRate
                        )
                    }

                    NavigationLink {
                        PaymentTermsEditView()
                    } label: {
                        SettingsRow(
                            icon: "calendar",
                            title: "Payment Terms",
                            detail: appState.businessProfile?.defaultPaymentTerms.displayName
                        )
                    }
                }

                Section("Subscription") {
                    HStack {
                        SettingsRow(icon: "creditcard", title: "Plan")
                        Spacer()
                        Text(appState.subscriptionStatus.plan.displayName)
                            .foregroundStyle(.secondary)
                    }

                    HStack {
                        SettingsRow(icon: "sparkles", title: "AI Usage")
                        Spacer()
                        Text("\(appState.usageMeter.generationsUsed) / \(appState.usageMeter.generationsLimit)")
                            .foregroundStyle(.secondary)
                    }
                }

                Section("Account") {
                    if let user = appState.currentUser {
                        HStack {
                            SettingsRow(icon: "person", title: "Name")
                            Spacer()
                            Text(user.displayName)
                                .foregroundStyle(.secondary)
                        }
                        HStack {
                            SettingsRow(icon: "envelope", title: "Email")
                            Spacer()
                            Text(user.email)
                                .foregroundStyle(.secondary)
                                .lineLimit(1)
                        }
                    }
                }

                Section {
                    Button(role: .destructive) {
                        appState.resetOnboarding()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Reset Onboarding")
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

private struct SettingsRow: View {
    let icon: String
    let title: String
    var detail: String? = nil

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(.blue)
                .frame(width: 24, alignment: .center)
            Text(title)
            if let detail {
                Spacer()
                Text(detail)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppState())
}
