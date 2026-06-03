import SwiftUI

struct BusinessProfileEditView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.dismiss) private var dismiss

    @State private var companyName = ""
    @State private var ownerName = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var website = ""
    @State private var address = ""
    @State private var licenseNumber = ""

    private var canSave: Bool {
        !companyName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !ownerName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !phone.trimmingCharacters(in: .whitespaces).isEmpty &&
        !email.trimmingCharacters(in: .whitespaces).isEmpty &&
        !address.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
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
                .padding(.top, 16)

                VStack(spacing: 16) {
                    FormField(label: "Company Name", text: $companyName, placeholder: "Your company name")
                    FormField(label: "Owner Name", text: $ownerName, placeholder: "Your name")
                    FormField(label: "Phone Number", text: $phone, placeholder: "(555) 000-1234", keyboard: .phonePad)
                    FormField(label: "Email", text: $email, placeholder: "you@example.com", keyboard: .emailAddress)
                    FormField(label: "Website", text: $website, placeholder: "Optional", keyboard: .URL)
                    FormField(label: "Business Address", text: $address, placeholder: "Street, City, State")
                    FormField(label: "License Number", text: $licenseNumber, placeholder: "Optional")
                }
                .padding(.horizontal, 24)
            }
        }
        .scrollDismissesKeyboard(.interactively)
        .navigationTitle("Business Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    save()
                    dismiss()
                }
                .disabled(!canSave)
            }
        }
        .onAppear { loadProfile() }
    }

    private func loadProfile() {
        guard let profile = appState.businessProfile else { return }
        companyName = profile.companyName
        ownerName = profile.ownerName
        phone = profile.phone
        email = profile.email
        website = profile.website ?? ""
        address = profile.address
        licenseNumber = profile.licenseNumber ?? ""
    }

    private func save() {
        guard var profile = appState.businessProfile else { return }
        profile.companyName = companyName.trimmingCharacters(in: .whitespaces)
        profile.ownerName = ownerName.trimmingCharacters(in: .whitespaces)
        profile.phone = phone.trimmingCharacters(in: .whitespaces)
        profile.email = email.trimmingCharacters(in: .whitespaces)
        profile.website = website.trimmingCharacters(in: .whitespaces).isEmpty ? nil : website.trimmingCharacters(in: .whitespaces)
        profile.address = address.trimmingCharacters(in: .whitespaces)
        profile.licenseNumber = licenseNumber.trimmingCharacters(in: .whitespaces).isEmpty ? nil : licenseNumber.trimmingCharacters(in: .whitespaces)
        appState.businessProfile = profile
    }
}

#Preview {
    NavigationStack {
        BusinessProfileEditView()
    }
    .environmentObject(AppState())
}
