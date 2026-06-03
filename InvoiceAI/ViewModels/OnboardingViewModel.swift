import Foundation
import SwiftUI

@MainActor
final class OnboardingViewModel: ObservableObject {
    enum Step: Int, CaseIterable, Equatable {
        case welcome
        case createAccount
        case businessProfile
        case taxSettings
        case paymentTerms
    }

    @Published var currentStep: Step = .welcome
    @Published var isLoading = false

    // Account
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""

    // Business profile
    @Published var companyName = ""
    @Published var ownerName = ""
    @Published var phone = ""
    @Published var businessEmail = ""
    @Published var website = ""
    @Published var address = ""
    @Published var licenseNumber = ""

    // Tax
    @Published var taxRateText = "8"
    @Published var taxEnabled = true

    // Payment terms
    @Published var selectedTermsOption: PaymentTermsOption = .dueUponReceipt
    @Published var customDaysText = ""

    private let authService: AuthService
    private let appState: AppState

    init(authService: AuthService, appState: AppState) {
        self.authService = authService
        self.appState = appState
    }

    var totalSteps: Int { Step.allCases.count }
    var currentStepIndex: Int { currentStep.rawValue }

    var canCreateAccount: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !email.trimmingCharacters(in: .whitespaces).isEmpty &&
        !password.isEmpty
    }

    var canSaveBusinessProfile: Bool {
        !companyName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !ownerName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !phone.trimmingCharacters(in: .whitespaces).isEmpty &&
        !businessEmail.trimmingCharacters(in: .whitespaces).isEmpty &&
        !address.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var resolvedPaymentTerms: PaymentTerms {
        selectedTermsOption.toPaymentTerms(customDays: Int(customDaysText) ?? 0)
    }

    func advance() {
        guard let next = Step(rawValue: currentStep.rawValue + 1) else { return }
        withAnimation(.easeInOut(duration: 0.3)) {
            currentStep = next
        }
    }

    func createAccount() async {
        isLoading = true
        defer { isLoading = false }
        do {
            let user = try await authService.signUp(
                email: email.trimmingCharacters(in: .whitespaces),
                password: password,
                displayName: name.trimmingCharacters(in: .whitespaces)
            )
            appState.currentUser = user
            ownerName = user.displayName
            businessEmail = user.email
            advance()
        } catch {
            // Mock always succeeds; real errors handled in future slice
        }
    }

    func completeOnboarding() {
        let rate = Decimal(string: taxRateText) ?? 8
        let taxSettings = TaxSettings(
            rate: rate / 100,
            label: "Sales Tax",
            isEnabled: taxEnabled
        )

        let profile = BusinessProfile(
            companyName: companyName.trimmed,
            ownerName: ownerName.trimmed,
            phone: phone.trimmed,
            email: businessEmail.trimmed,
            website: website.trimmed.isEmpty ? nil : website.trimmed,
            address: address.trimmed,
            licenseNumber: licenseNumber.trimmed.isEmpty ? nil : licenseNumber.trimmed,
            defaultTaxSettings: taxSettings,
            defaultPaymentTerms: resolvedPaymentTerms
        )
        appState.businessProfile = profile
        appState.completeOnboarding()
    }
}

// MARK: - Payment Terms Option

enum PaymentTermsOption: String, CaseIterable, Identifiable {
    case dueUponReceipt
    case net7
    case net15
    case net30
    case custom

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .dueUponReceipt: return "Due Upon Receipt"
        case .net7: return "Net 7"
        case .net15: return "Net 15"
        case .net30: return "Net 30"
        case .custom: return "Custom"
        }
    }

    func toPaymentTerms(customDays: Int = 0) -> PaymentTerms {
        switch self {
        case .dueUponReceipt: return .dueUponReceipt
        case .net7: return .net7
        case .net15: return .net15
        case .net30: return .net30
        case .custom: return .custom(days: max(1, customDays))
        }
    }
}

// MARK: - String Helper

private extension String {
    var trimmed: String {
        trimmingCharacters(in: .whitespaces)
    }
}
